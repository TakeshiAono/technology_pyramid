import './Workspace.css'
import React, { useEffect, useState, useRef } from "react"
import Technology from "./Technology";
import Arrow from "./Arrow";
import useArrow from "../hooks/useArrow";
import useComponentArray from "../hooks/useComponentArray";

const Workspace = (props) => {
  const [selectedNodes, setSelectedNodes] = useState([])
  const [topTechnology, setTopTechnology] = useState(null)
  const [arrows, setArrows] = useState([])
  const [getArrowProperties] = useArrow(null)
  const technologyRefs = useRef([])
  const beforeMovePosition = useRef()
  const afterMovePosition = useRef()

  const arrowHandler = () => {
    const childElements = selectedNodes.map((selectedId) => {
      return(technologyRefs.current.find((element) => element.current.id == selectedId)
    )})
    childElements.forEach((element) => {
      const arrowProperties = getArrowProperties(topTechnology, element.current)
      setArrows(prevArrows => [...prevArrows, <Arrow width={arrowProperties.rect.width} height={arrowProperties.rect.height} startPosition={[arrowProperties.positions.startPosition.x, arrowProperties.positions.startPosition.y]}/>])
    })
  }

  const mousePosition = (evt) => {
    return {x: evt.pageX, y: evt.pageY}
  }

  const haveNode = (evt) => {
      const techElement = evt.target
      techElement.style.position = 'absolute'
      beforeMovePosition.current = mousePosition(evt)
      console.log("beforeMovePosition", beforeMovePosition)
  }

  const dragEndHandler = (evt) => {
    afterMovePosition.current = mousePosition(evt)
    console.log('beforeMovePosition',beforeMovePosition.current)
    const differentialMousePosX = afterMovePosition.current.x - beforeMovePosition.current.x
    const differentialMousePosY = afterMovePosition.current.y - beforeMovePosition.current.y
    evt.target.style.left = (evt.pageX - evt.nativeEvent.offsetX + differentialMousePosX) + "px"
    evt.target.style.top = (evt.pageY - evt.nativeEvent.offsetY + differentialMousePosY) + "px"
  }

  const selectHandler = (e) => {
    //TODO:topTechnologyHandlerと順序依存関係あるため要修正
    if (e.ctrlKey) {
      if (!selectedNodes.includes(e.target.id)) {
        setSelectedNodes([...selectedNodes, e.target.id])
      }
    }
    else if(e.keydown == null) {
      setSelectedNodes([e.target.id])
      setTopTechnology(null)
    }
  }

  const topTechnologyHandler = (e) => {
    //TODO:selectHandlerと順序依存関係あるため要修正
    if (e.shiftKey) {
      setTopTechnology(e.target)
      setSelectedNodes(selectedNodes.filter((value) => value !== e.target.id))
    }
  }

  const technologyHandler = (e) => {
    haveNode(e)
    e.stopPropagation()
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
            <div draggable onMouseDown={(e) => {
              selectHandler(e)
              topTechnologyHandler(e)
              e.stopPropagation()
              }
              } 
              onDragStart={technologyHandler} onDragEnd={dragEndHandler}
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
