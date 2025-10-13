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
}

export type TechnologyRefInfo = {
  element: Konva.Group;
  technologyParams: TechnologyParams;
}

const PyramidCanvas = ({ technologyParamsList }: { technologyParamsList: TechnologyParams[] }) => {
  const [isChildNodeCahnge, setIsChildNodeCahnge] = useState(false)
  const [documentElementMaxWidth, setDocumentElementMaxWidth] = useState(document.scrollingElement.scrollWidth);
  const [documentElementMaxHeight, setDocumentElementMaxHeight] = useState(document.scrollingElement.scrollHeight);
  const [clickTechnologyId, setClickTechnologyId] = useState<number | null>(null);

  const technologyInfos = useRef<TechnologyRefInfo[]>([])

  useEffect(() => {
    setIsChildNodeCahnge(false)
  }, [isChildNodeCahnge])

  const technologiesByLayer = useMemo(() =>
    _.groupBy(technologyParamsList, technologyParams => technologyParams.current_layer)
    , [technologyParamsList]
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
        return { element: updatedElement, technologyParams: updatedTechnologyParams }
      } else {
        return { element: technologyInfo.element, technologyParams: technologyInfo.technologyParams }
      }
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

  const technologyNodes = useMemo(() => {
    return _.map(technologiesByLayer, (technologyParamsList, layerIndexString) =>
      technologyParamsList.map((technologyParams, index) => <TechnologyNode
        mountRef={createTechnologyInfo}
        updateRef={updateRef}
        technologyParams={technologyParams}
        xPos={100 + index * 350}
        yPos={Number(layerIndexString) * 250}
        clickTechnologyId={clickTechnologyId}
        onClickCallBack={(selectedTechId) => { setClickTechnologyId(selectedTechId); console.log("selectedTechId", selectedTechId) }}
      />)
    )
  }, [technologiesByLayer, clickTechnologyId])

  const createArrows = useMemo(() => {
    return technologyInfos.current.map(technologyInfo => {
      const childElement = technologyInfo.element
      const parentTechnologyInfos = technologyInfos.current.find(targetTechnologyInfo => targetTechnologyInfo.technologyParams.current_tech_id === technologyInfo.technologyParams.upper_tech_id)
      // 最上位のテクノロジーは親が存在しないためその場合は早期リターンさせる
      if (parentTechnologyInfos === undefined) return

      const parentTechnologyElement = parentTechnologyInfos.element
      return <Arrow
        x={0}
        y={0}
        points={[
          parentTechnologyElement.x(),
          parentTechnologyElement.y(),
          childElement.x(),
          childElement.y()
        ]}
        fill="black"
        stroke="black"
        strokeWidth={2}
      />
    })
  }, [technologyInfos.current])

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
