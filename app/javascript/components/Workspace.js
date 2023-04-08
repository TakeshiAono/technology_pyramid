import './Workspace.css'
import React, { useEffect, useState, useRef } from "react"
import Technology from "./Technology";
import Arrow from "./Arrow";
import useArrow from "../hooks/useArrow";
import useComponentArray from "../hooks/useComponentArray";

const Workspace = (props) => {
  const [selectedNodes, setSelectedNodes] = useState([])
  const [topTechnology, setTopTechnology] = useState(null)
  const [positions, setPositions] = useState([])
  const [arrows, setArrows] = useState([])
  const [getArrowProperties] = useArrow(null)

  const arrowHandler = () => {
    const childElements = selectedNodes.map((selectedId) => 
    technologies.find((element) => element.id == selectedId
    ))
    childElements.forEach((element) => {
      const arrowProperties = getArrowProperties(topTechnology, element)
      console.log('arrowProperties',arrowProperties)
      setArrows(prevArrows => [...prevArrows, <Arrow width={arrowProperties.rect.width} height={arrowProperties.rect.height} startPosition={[arrowProperties.positions.startPosition.x, arrowProperties.positions.startPosition.y]}/>])
    })
  }

  const mousePosition = (evt) => {
    return {x: evt.pageX, y: evt.pageY}
  }

  const haveNode = (techNodeEvt) => {
    const handler = (winEvt) => {
      techElement.style.position = 'absolute'
      const movedMousePosition = mousePosition(winEvt)
      const differentialMousePosX = movedMousePosition.x - beforeMousePosition.x
      const differentialMousePosY = movedMousePosition.y - beforeMousePosition.y
      techElement.style.left = (techNodeEvt.pageX - techNodeEvt.nativeEvent.offsetX + differentialMousePosX) + "px"
      techElement.style.top = (techNodeEvt.pageY - techNodeEvt.nativeEvent.offsetY + differentialMousePosY) + "px"
    }
    const techElement = techNodeEvt.target
    let beforeMousePosition
    beforeMousePosition = mousePosition(techNodeEvt)
    window.addEventListener("mousemove", handler)
    window.addEventListener("mouseup", (winEvt) => {
      beforeMousePosition = mousePosition(winEvt)
      window.removeEventListener("mousemove", handler)
    })
  }

  const selectHandler = (e) => {
    if (e.ctrlKey) {
      if (!selectedNodes.includes(e.target.id)) {
        setSelectedNodes([...selectedNodes, e.target.id])
      }
    }else if(e.keydown == null) {
      setSelectedNodes([e.target.id])
      setTopTechnology(null)
    }
  }

  const topTechnologyHandler = (e) => {
    if (e.shiftKey) {
      setTopTechnology(e.target)
      setSelectedNodes(selectedNodes.filter((value) => value !== e.target.id))
    }
  }

  const mouseDownHandler = (e) => {
    haveNode(e)
    selectHandler(e)
    e.stopPropagation()
    topTechnologyHandler(e)
  }

  const callbacks = {
    selectedNodes,
    setSelectedNodes,
    topTechnology,
    setTopTechnology,
    onMouseDown: mouseDownHandler,
    test: (e) => {setPositions(e)}
  }

  const [technologies, constructTechnologies] = useComponentArray(props.technologies, Technology, callbacks)

  return(
    <div className="workspace" onMouseDown={() =>{
      console.log("workspace")
      setSelectedNodes([])
      setTopTechnology(null)
    }}>
      <button onMouseDown={(e) =>{
        arrowHandler(e)
        e.stopPropagation()
      }
      }>矢印描画</button>
        {constructTechnologies()}
      {arrows}
    </div>
  )
}

export default Workspace
