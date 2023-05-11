import './Workspace.css'
import React, { useEffect, useState, useRef, MutableRefObject } from "react"
import Technology from "./Technology";
import Arrow from "./Arrow";
import {useArrow, ArrowPosRect} from "../hooks/useArrow";
import useComponentArray from "../hooks/useComponentArray";
import useTechnology from '../hooks/useTechnology';

type workspaceProps = {
  technologies: HTMLDivElement[]
}

const Workspace = (props: workspaceProps) => {
  const technologyRefs: {current: HTMLDivElement[]} = useRef<RefObject<HTMLInputElement>[]>([])
  const [topTechnologyId, setTopTechnologyId] = useState("")
  const [selectedNodeIds, setSelectedNodeIds] = useState<string[]>([])
  const [arrows, setArrows] = useState([]) //【TODO】DOMが入っているためid(string)が入るように修正する
  const [
    liftUpTechnology,
    liftDown,
    selectTechnology
  ] = useTechnology(topTechnologyId, setTopTechnologyId, selectedNodeIds, setSelectedNodeIds)
  const [getArrowProperties]: [(startElementId: string, endElementId: string) => ArrowPosRect] = useArrow(technologyRefs)
  
  const arrowMove = (e: React.DragEvent<HTMLInputElement>): void => {
    const targetTechnology: HTMLDivElement = e.target
    if (typeof targetTechnology){
      // console.log(e.target.children[0])
      // const targetTechnology = e.target.children[0]
    } else{
    }

    // const targetElement = e.target as HTMLDivElement;
    // const targetTechnology = targetElement.children[0] as HTMLDivElement | undefined;

    // if (targetTechnology) {
    //   console.log(targetTechnology);
    // }

  }

  const resetTechnologies = () => {
    setSelectedNodeIds([])
    setTopTechnologyId(null)
  }

  const createArrow = (): void => {
    selectedNodeIds.forEach((selectedNodeId) => {
      const arrowProperties = getArrowProperties(topTechnologyId, selectedNodeId)
      setArrows(arrows => {return(
        [
          ...arrows, 
          <Arrow
            key={topTechnologyId + "," + selectedNodeId} //TODO データベースのarrowのidを取得に変更
            startTech = {topTechnologyId}
            endTech = {selectedNodeId}
            width={arrowProperties.rect.width}
            height={arrowProperties.rect.height}
            startPosition={[arrowProperties.positions.startPosition.x, arrowProperties.positions.startPosition.y]}
          />
        ]
      )})
    })
  }

  return(
    <div className="workspace" onMouseDown={resetTechnologies}>
      {arrows}
      <button onMouseDown={(e) =>{
        createArrow()
        e.stopPropagation()
      }
      }>矢印描画</button>
        {props.technologies.map((technology, i) => {
          technologyRefs.current[i]  = React.createRef()
          return(
            <div draggable
              onMouseDown={(e) => {
                selectTechnology(e)
                e.stopPropagation()
              }}
              onDragStart={(e) =>{
                liftUpTechnology(e)
                arrowMove(e)
              }}
              onDragEnd={liftDown}
            >
              <Technology
                name={technology.name}
                key={technology.id}
                id={technology.id}
                ref={technologyRefs.current[i]}
                selectedNodeIds={selectedNodeIds}
                topTechnologyId={topTechnologyId}
              />
            </div>
          )
        })}
    </div>
  )
}

export default Workspace
