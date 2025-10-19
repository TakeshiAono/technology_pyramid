import React, { useCallback, useEffect, useMemo, useRef, useState } from "react"
import { Stage, Layer, Arrow } from 'react-konva';
import _ from "lodash";
import Konva from "konva";

import TechnologyNode from "./TechnologyNode";
import useKeyBoardShortcut from "../hooks/useKeyBoardShortcut";

export type TechnologyParams = {
  current_layer: number;
  current_tech_name: string;
  // 最上位のテクノロジーはそれより上位のテクノロジーが存在しないためnullを許容する
  current_tech_id: number | null;
  upper_tech_id: number | null;
  x_pos: number;
  y_pos: number;
  top_technology_id: number;
  tech_pos_id: number;
  description: string;
}

export type TechnologyNedeParams =
  TechnologyParams & {
    isUpdated: boolean;
  }

export type TechnologyRefInfo = {
  element: Konva.Group;
  technologyParams: TechnologyNedeParams;
}

const PyramidCanvas = ({ technologyParamsList }: { technologyParamsList: TechnologyParams[] }) => {
  // 最終的には最初のレンダリングはtechnologyParamsListを使用し、その後はtechnologyInfosのデータをもとに
  // レンダリングをするようにすればtechnologyParamsListStateは不要となるが
  // まだロジックができていないため、新規にテクノロジーを追加した時は
  // technologyParamsListStateとtechnologyInfosどちらのデータも更新が必要
  const [technologyParamsListState, setTechnologyParamsListState] =
    useState<TechnologyNedeParams[]>(technologyParamsList.map(technologyParams => ({ ...technologyParams, isUpdated: false })))
  const [isChildNodeCahnge, setIsChildNodeCahnge] = useState(false)
  const [documentElementMaxWidth, setDocumentElementMaxWidth] = useState(document.scrollingElement.scrollWidth);
  const [documentElementMaxHeight, setDocumentElementMaxHeight] = useState(document.scrollingElement.scrollHeight);
  const [clickTechnologyId, setClickTechnologyId] = useState<number | null>(null);

  // technologyParamsListStateはtechnologyInfosと違い、ref(DOM)情報は保持していない。
  // refを保持しないと矢印のレンダリングや座標の変更などができないため定義
  // TODO: technologyParamsListStateとtechnologyInfosで重複管理しているデータがあるので修正が必要
  const technologyInfos = useRef<TechnologyRefInfo[]>([])

  const any_updated = () => {
    const updatedTechnologyParamsList = technologyParamsListState.filter(technologyParams => technologyParams.isUpdated)
    return updatedTechnologyParamsList.length > 0
  }

  const updateDiffTechnologies = async () => {
    const path = location.pathname;
    const match = path.match(/\/works\/(\d+)\/technologies\/(\d+)/);
    const workId = match[1];
    const technologyId = match[2];

    const csrfToken = document
      .querySelector('meta[name="csrf-token"]')
      ?.getAttribute("content");

    const updatedTechnologyParamsList = technologyParamsListState.filter(technologyParams => technologyParams.isUpdated)
    if (updatedTechnologyParamsList.length === 0) return

    try {
      const response = await fetch(
        `/works/${workId}/technologies/${technologyId}/api_update_all_diff`,
        {
          headers: {
            "Content-Type": "application/json",
            "X-CSRF-Token": csrfToken || "",
          },
          method: "put",
          body: JSON.stringify({ technologies: updatedTechnologyParamsList })
        }
      )

      if (response.status === 200) {
        setTechnologyParamsListState(prev => prev.map(technologyParams => ({ ...technologyParams, isUpdated: false })))
      }
    } catch (error) {
      console.error(`Error: ${error}`)
    }
  }

  useKeyBoardShortcut({
    "Ctrl+Shift+S": updateDiffTechnologies
  })

  useEffect(() => {
    setIsChildNodeCahnge(false)
  }, [isChildNodeCahnge])

  const technologiesByLayer = useMemo(() =>
    _.groupBy(technologyParamsListState, technologyParams => technologyParams.current_layer)
    , [technologyParamsListState]
  )

  // 矢印を出力する時にTechnologyNodeのDOM要素が必要
  // DOM要素をバックし、親で管理するためのメソッド
  const createTechnologyInfo = useCallback(({ element: createdElement, technologyParams }: TechnologyRefInfo) => {
    setIsChildNodeCahnge(true)
    technologyInfos.current = [...technologyInfos.current, { element: createdElement, technologyParams }]

    updateDocumentElementWidthAndHeight(createdElement)
  }, [])

  const updateRef = useCallback(({ element: updatedElement, technologyParams: updatedTechnologyParams }: TechnologyRefInfo) => {
    setIsChildNodeCahnge(true)

    // technologyInfosの中の更新があった要素だけを置き換えたリストを生成する
    technologyInfos.current = technologyInfos.current.map(technologyInfo => {
      if (technologyInfo.technologyParams.current_tech_id === updatedTechnologyParams.current_tech_id) {
        updatedTechnologyParams.isUpdated = true
        return { element: updatedElement, technologyParams: updatedTechnologyParams }
      } else {
        return { element: technologyInfo.element, technologyParams: technologyInfo.technologyParams }
      }
    })

    setTechnologyParamsListState((prev) => {
      return prev.map((techParams) => {
        if (techParams.current_tech_id === updatedTechnologyParams.current_tech_id) {
          techParams.isUpdated = true
          return updatedTechnologyParams
        } else {
          return techParams
        }
      })
    })

    updateDocumentElementWidthAndHeight(updatedElement)
  }, [])

  const updateDocumentElementWidthAndHeight = (targetElement: Konva.Group) => {
    // Konva.Groupはwidthとheightの情報を持っていないため
    // targetElementの背景用のRectを取得
    const backGroudRect = targetElement.find("Rect")[0]
    const areaBuffer = 50
    setDocumentElementMaxWidth(prev =>
      Math.max(prev, targetElement.x() + backGroudRect.width() + areaBuffer)
    );
    setDocumentElementMaxHeight(prev =>
      Math.max(prev, targetElement.y() + backGroudRect.height() + areaBuffer)
    );
  }

  const addNewTechnologyNode = (technologyParams: TechnologyNedeParams) => {
    setTechnologyParamsListState([...technologyParamsListState, technologyParams])
  }

  const goToLinkPage = async (technologyId: number) => {
    const path = location.pathname;
    const match = path.match(/\/works\/(\d+)/);
    const workId = match[1];

    const permit = any_updated() ? window.confirm("編集途中の内容がリセットされてしまいますが別ページに遷移してもよろしいですか?") : true
    if (permit) {
      window.location.href = `/works/${workId}/technologies/${technologyId}/links`;
    }
  }

  const technologyNodes = useMemo(() => {
    return _.map(technologiesByLayer, (technologyParamsListState) =>
      technologyParamsListState.map((technologyParams) => <TechnologyNode
        mountRef={createTechnologyInfo}
        updateRef={updateRef}
        addNewTechnology={addNewTechnologyNode}
        technologyParams={technologyParams}
        xPos={technologyParams.x_pos}
        yPos={technologyParams.y_pos}
        clickTechnologyId={clickTechnologyId}
        onClickCallBack={(selectedTechId) => { setClickTechnologyId(selectedTechId); console.log("selectedTechId", selectedTechId) }}
        topTechnologyId={technologyParams.top_technology_id}
        goToLinkPage={goToLinkPage}
      />)
    )
  }, [technologiesByLayer, clickTechnologyId, technologyParamsListState])

  const createArrows = useMemo(() => {
    return technologyInfos.current.map(technologyInfo => {
      const childElement = technologyInfo.element
      const parentTechnologyInfos = technologyInfos.current.find(targetTechnologyInfo => targetTechnologyInfo.technologyParams.current_tech_id === technologyInfo.technologyParams.upper_tech_id)
      // 最上位のテクノロジーは親が存在しないためその場合は早期リターンさせる
      if (parentTechnologyInfos === undefined) return

      const parentTechnologyElement = parentTechnologyInfos.element
      const parentWidthCenterDistance = parentTechnologyElement.children[0].width() / 2
      const parentHeight = parentTechnologyElement.children[0].height()
      const childWidthCenterDistance = childElement.children[0].width() / 2
      return <Arrow
        x={0}
        y={0}
        points={[
          parentTechnologyElement.x() + parentWidthCenterDistance,
          parentTechnologyElement.y() + parentHeight,
          childElement.x() + childWidthCenterDistance,
          childElement.y()
        ]}
        fill="black"
        stroke="black"
        strokeWidth={2}
      />
    })
  }, [technologyInfos.current, technologyParamsListState])

  return (
    <>
      <Stage
        width={documentElementMaxWidth}
        height={documentElementMaxHeight}
        onClick={() => { setClickTechnologyId(null) }}
      >
        <Layer>
          {technologyNodes}
        </Layer>
        <Layer>
          {createArrows}
        </Layer>
      </Stage >
    </>
  )
}

export default PyramidCanvas
