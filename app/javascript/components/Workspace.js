import './Workspace.css'
import React, { useEffect, useState, useRef } from "react"
import Technology from "./Technology";
import Arrow from "./Arrow";
import useArrow from "../hooks/useArrow";
import useComponentArray from "../hooks/useComponentArray";
import useTechnology from '../hooks/useTechnology';

const Workspace = (props) => {
  const [arrows, setArrows] = useState([])
  const [technologyRefs, topTechnologyId, setTopTechnologyId, selectedNodeIds, setSelectedNodeIds, liftUpTechnology, liftDown, selectTechnology] = useTechnology()
  const [getArrowProperties] = useArrow(technologyRefs)

  const arrowHandler = () => {
    selectedNodeIds.forEach((selectedNodeId) => {
      const arrowProperties = getArrowProperties(topTechnologyId, selectedNodeId)
      setArrows(prevArrows => [...prevArrows, <Arrow width={arrowProperties.rect.width} height={arrowProperties.rect.height} startPosition={[arrowProperties.positions.startPosition.x, arrowProperties.positions.startPosition.y]}/>])
    })
  }

  const resetTechnologies = () => {
    setSelectedNodeIds([])
    setTopTechnologyId(null)
  }

  return(
    <div className="workspace" onMouseDown={resetTechnologies}>
      {arrows}
      <button onMouseDown={(e) =>{
        arrowHandler(e)
        e.stopPropagation()
      }
      }>矢印描画</button>
        {props.technologies.map((technology, i) => {
          technologyRefs.current[i] = React.createRef()
          return(
            <div draggable
              onMouseDown={(e) => {
                selectTechnology(e)
                e.stopPropagation()
              }}
              onDragStart={liftUpTechnology}
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
