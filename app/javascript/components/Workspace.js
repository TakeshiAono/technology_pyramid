import './Workspace.css'
import React, { useEffect, useState, useRef } from "react"
import Technology from "./Technology";
import Arrow from "./Arrow";
import useArrow from "../hooks/useArrow";
import useComponentArray from "../hooks/useComponentArray";
import useTechnology from '../hooks/useTechnology';

const Workspace = (props) => {
  const [arrows, setArrows] = useState([])
  const [getArrowProperties] = useArrow(null)
  const technologyRefs = useRef([])
  const [topTechnology, setTopTechnology, selectedNodes, setSelectedNodes, liftUpTechnology, liftDown, selectTechnology] = useTechnology()

  const arrowHandler = () => {
    const childElements = selectedNodes.map((selectedId) => {
      return(technologyRefs.current.find((element) => element.current.id == selectedId)
    )})
    childElements.forEach((element) => {
      const arrowProperties = getArrowProperties(topTechnology, element.current)
      setArrows(prevArrows => [...prevArrows, <Arrow width={arrowProperties.rect.width} height={arrowProperties.rect.height} startPosition={[arrowProperties.positions.startPosition.x, arrowProperties.positions.startPosition.y]}/>])
    })
  }

  return(
    <div className="workspace" onMouseDown={() =>{
      //resetアクション
      setSelectedNodes([null])
      setTopTechnology(null)
    }}>
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
                selectedNodes={selectedNodes}
                topTechnology={topTechnology}
              />
            </div>
          )
        })}
    </div>
  )
}

export default Workspace
