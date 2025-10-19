import React, { useEffect, useRef, useState } from "react"
import { Rect, Text, Transformer, Group } from 'react-konva';
import { Html } from "react-konva-utils";
import { TechnologyNedeParams, TechnologyRefInfo } from "./PyramidCanvas";
import Konva from "konva";

type TechnologyNode = {
  technologyParams: TechnologyNedeParams;
  xPos: number;
  yPos: number;
  mountRef: (val: TechnologyRefInfo) => void;
  updateRef: (val: TechnologyRefInfo) => void;
  clickTechnologyId: number | null;
  onClickCallBack: (technologyId: number | null) => void;
  addNewTechnology: (technologyParams: TechnologyNedeParams) => void;
  topTechnologyId: number;
  goToLinkPage: (technologyId: number) => void;
}

const TechnologyNode = ({
  technologyParams,
  mountRef,
  updateRef,
  xPos,
  yPos,
  clickTechnologyId,
  onClickCallBack,
  addNewTechnology,
  topTechnologyId,
  goToLinkPage,
}: TechnologyNode) => {
  const [canTitleEdit, setCanTitleEdit] = useState(false)
  const [canDescriptionEdit, setCanDescriptionEdit] = useState(false)
  const [title, setTitle] = useState(technologyParams.current_tech_name)
  const [description, setDescription] = useState(technologyParams.description)
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

  const postTechnology = async () => {
    const path = location.pathname;
    const match = path.match(/\/works\/(\d+)\/technologies\/(\d+)/);
    const workId = match[1];
    const technologyId = match[2];

    const csrfToken = document
      .querySelector('meta[name="csrf-token"]')
      ?.getAttribute("content");
    try {
      const newTechRelativeDistance = 300
      const defaultName = "xxx"
      const response = await fetch(
        `/works/${workId}/technologies/${technologyId}/api_create`,
        {
          headers: {
            "Content-Type": "application/json",
            "X-CSRF-Token": csrfToken || "",
          },
          method: "post",
          body: JSON.stringify({
            technology: {
              name: defaultName,
              upper_technology_id: technologyParams.current_tech_id,
              description: "",
              x_pos: technologyParams.x_pos,
              y_pos: technologyParams.y_pos + newTechRelativeDistance,
              top_technology_id: topTechnologyId,
            }
          })
        }
      )
      const data = await response.json();
      addNewTechnology({
        current_layer: technologyParams.current_layer + 1,
        current_tech_name: defaultName,
        current_tech_id: data.technology_id,
        upper_tech_id: technologyParams.current_tech_id,
        x_pos: technologyParams.x_pos,
        y_pos: technologyParams.y_pos + newTechRelativeDistance,
        top_technology_id: topTechnologyId,
        tech_pos_id: data.tech_pos_id,
        description: "",
        isUpdated: false,
      })
    } catch (error) {
      console.error(`Error: ${error}`)
    }
  }

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
          updateRef({
            element: groupRef.current,
            technologyParams: {
              ...technologyParams,
              x_pos: groupRef.current.x(),
              y_pos: groupRef.current.y(),
            }
          })
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
          fill={technologyParams.isUpdated ? "yellow" : ""}
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
                updateRef({
                  element: groupRef.current,
                  technologyParams: {
                    ...technologyParams,
                    current_tech_name: e.target.value,
                  }
                })
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
            onClick={() => { onlyEditSelect("title") }}
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
                  defaultValue={description}
                  style={{ ...InputStyle, ...DescriptionStyle }}
                  onChange={(e) => {
                    setDescription(e.target.value)
                    updateRef({
                      element: groupRef.current,
                      technologyParams: {
                        ...technologyParams,
                        description: e.target.value,
                      }
                    })
                  }}
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
            width={120}
            height={30}
            shadowColor="black"
            fill={"lightcyan"}
            cornerRadius={5}
          >
          </Rect>
          <Text text="子要素を追加" fontSize={15} x={15} y={8} />
        </Group>
        <Group
          width={100}
          height={50}
          x={230}
          y={150}
          onClick={() => { goToLinkPage(technologyParams.current_tech_id) }}
          onMouseOver={(e) => {
            e.target
            console.log(e.target.getStage().container())
            e.target.getStage().container().style.cursor = "pointer"
          }}
          onMouseLeave={(e) => {
            e.target.getStage().container().style.cursor = "default"
          }}
        >
          <Rect
            stroke="#555"
            width={60}
            height={30}
            shadowColor="black"
            fill={"teal"}
            cornerRadius={5}
          >
          </Rect>
          <Text text="リンク" fontSize={15} fill={"white"} x={8} y={8} />
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
              updateRef({
                element: groupRef.current,
                technologyParams: {
                  ...technologyParams,
                  x_pos: groupRef.current.x(),
                  y_pos: groupRef.current.y(),
                }
              })
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
