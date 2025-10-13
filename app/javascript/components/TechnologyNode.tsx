import React, { act, RefObject, useEffect, useRef, useState } from "react"
import { Stage, Layer, Rect, Circle, Text, Arrow, Transformer, Group, Label, Tag } from 'react-konva';
import { Html } from "react-konva-utils";
import { TechnologyParams, TechnologyRefInfo } from "./PyramidCanvas";
import Konva from "konva";
import { initial } from "lodash";

type TechnologyNode = {
  technologyParams: TechnologyParams;
  xPos: number;
  yPos: number;
  mountRef: (val: TechnologyRefInfo) => void;
  updateRef: (val: TechnologyRefInfo) => void;
  clickTechnologyId: number | null;
  onClickCallBack: (technologyId: number | null) => void;
}

const TechnologyNode = ({ technologyParams, mountRef, updateRef, xPos, yPos, clickTechnologyId, onClickCallBack }: TechnologyNode) => {
  const [canTitleEdit, setCanTitleEdit] = useState(false)
  const [canDescriptionEdit, setCanDescriptionEdit] = useState(false)
  const [title, setTitle] = useState(technologyParams.current_tech_name)
  const [description, setDescription] = useState("")
  const [isDragging, setIsDragging] = useState(false)

  const groupRef = useRef<Konva.Group | null>(null);
  const transformRef = useRef<Konva.Transformer | null>(null);

  useEffect(() => {
    if (clickTechnologyId === null) return

    switchDisplayTransformer();
    if (clickTechnologyId !== technologyParams.current_tech_id) inputEditStateInitialize()
  }, [canTitleEdit, canDescriptionEdit, isDragging, clickTechnologyId]);

  useEffect(() => {
    if (mountRef) mountRef({ element: groupRef.current, technologyParams: technologyParams })
  }, [mountRef])

  const isClickedCurrentNode = () => (clickTechnologyId === technologyParams.current_tech_id)

  const switchDisplayTransformer = () => {
    console.log("(clickTechnologyId === technologyParams.current_tech_id)", (clickTechnologyId === technologyParams.current_tech_id))
    if (isClickedCurrentNode()) {
      transformRef.current.attachTo(groupRef.current);
    } else {
      transformRef.current?.detach()
    }
  }

  const inputEditStateInitialize = () => {
    setCanDescriptionEdit(false)
    setCanTitleEdit(false)
  }

  // 他のedit状態がアクティブになるのを防ぐためのメソッド
  const onlyEditSelect = (targetEdit: "title" | "description") => {
    switch (targetEdit) {
      case "title":
        setCanDescriptionEdit(false)
        setCanTitleEdit(true)
        break;
      case "description":
        setCanDescriptionEdit(true)
        setCanTitleEdit(false)
        break;
    }
  }

  const postTechnology = () => {
    const path = location.pathname;

    const match = path.match(/\/works\/(\d+)\/technologies\/(\d+)/);
    const workId = match[1];
    const technologyId = match[2];

    const csrfToken = document
      .querySelector('meta[name="csrf-token"]')
      ?.getAttribute("content");
    fetch(
      `/works/${workId}/technologies/${technologyId}/api`,
      {
        headers: {
          "Content-Type": "application/json", // JSONを送ることを明示
          "X-CSRF-Token": csrfToken || "", // Railsがこれをチェックする
        },
        method: "post",
        body: JSON.stringify({
          technology: {
            name: "xxx",
            upper_technology_id: technologyParams.current_tech_id,
            description: "test"
          }
        })
      }
    )
  }


  // const textRef = useRef(null);
  // const inputRef = useRef(null);
  // const [invScale, setInvScale] = useState({ x: 1, y: 1 });

  // const updateInvScale = () => {
  //   const g = groupRef.current;
  //   if (!g) return;
  //   const s = g.getAbsoluteScale();
  //   // Text は見た目サイズを保つため逆スケールを当てる
  //   textRef.current?.scale({ x: 1 / s.x, y: 1 / s.y });
  //   textRef.current?.getLayer()?.batchDraw();
  //   // HTML入力は invScale を state で渡す
  //   setInvScale({ x: 1 / s.x, y: 1 / s.y });
  // };

  // const staticScale = `scale(${invScale.x}, ${invScale.y})`

  return (
    <>
      <Group
        x={xPos}
        y={yPos}
        draggable
        onClick={(e) => {
          e.cancelBubble = true
          setIsDragging(true)
          onClickCallBack(technologyParams.current_tech_id)
          inputEditStateInitialize()
        }}
        ref={groupRef}
        // onTransform={() => updateInvScale}
        onDragMove={() => {
          updateRef({ element: groupRef.current, technologyParams })
          onClickCallBack(technologyParams.current_tech_id)
          setIsDragging(true)
        }}
        onDragEnd={() => {
          setIsDragging(false)
        }}
      >
        <Rect
          stroke="#555"
          width={TechonologyCardStyle.width}
          height={TechonologyCardStyle.height}
          shadowColor="black"
          cornerRadius={5}
        />
        {canTitleEdit ?
          <Html>
            <input
              // ref={inputRef}
              defaultValue={title}
              onChange={(e) => {
                setTitle(e.target.value)
                onClickCallBack(technologyParams.current_tech_id)
                setCanDescriptionEdit(false)
              }}
              style={{
                ...InputStyle,
                fontSize: 30,
                // transform: staticScale,
                transformOrigin: "top left",
              }}
            />
          </Html>
          :
          <Text
            y={5}
            x={5}
            width={TechonologyCardStyle.width}
            // ref={textRef}
            text={title}
            fontSize={30}
            fontFamily="Calibri"
            offsetX={0}
            onClick={() => { onlyEditSelect("title"); console.log("クリ九された") }}
          />
        }
        <Group
          width={100}
          height={300}
          x={0}
          y={40}
        >
          {
            canDescriptionEdit ?
              <Html>
                <textarea
                  style={{ ...InputStyle, ...DescriptionStyle }}
                  onChange={(e) => setDescription(e.target.value)}
                  value={description}
                  onClick={() => {
                    onClickCallBack(technologyParams.current_tech_id)
                    setCanTitleEdit(false)
                  }}
                />
              </Html>
              :
              <Text
                text={description}
                onClick={() => onlyEditSelect("description")}
                width={TechonologyCardStyle.width}
                height={100}
              />
          }
        </Group>
        <Group
          width={100}
          height={50}
          x={100}
          y={150}
          onClick={postTechnology}
        >
          <Rect
            stroke="#555"
            width={150}
            height={30}
            shadowColor="black"
            fill={"lightcyan"}
            cornerRadius={5}
          >
          </Rect>
          <Text text="子要素を追加" fontSize={15} x={15} y={8} />
        </Group>
      </Group >
      {isClickedCurrentNode() && (
        <>
          <Transformer
            ref={transformRef}
            flipEnabled={false}
            boundBoxFunc={(oldBox, newBox) => {
              if (Math.abs(newBox.width) < 5 || Math.abs(newBox.height) < 5) {
                return oldBox;
              }
              return newBox;
            }}
            onTransform={() => {
              updateRef({ element: groupRef.current, technologyParams })
            }}
          />
        </>
      )
      }
    </>
  )
}

const TechonologyCardStyle = {
  width: 300,
  height: 200
}

const InputStyle = {
  width: TechonologyCardStyle.width,
  background: "transparent",
  border: "none",
  outline: "none",
  padding: 0,
  margin: 0,
  fontFamily: "Calibri, sans-serif",
  lineHeight: "1",
}

const DescriptionStyle = {
  height: 100,
}

export default TechnologyNode
