import React, { useEffect, useState, useRef } from "react"
import Technology from "./Technology";
import Arrow from "./Arrow";
import './Workspace.css'
import { render } from "react-dom";
import useComponentArray from "../hooks/useComponentArray";


const Workspace = (props) => {
  const [selectedNodes, setSelectedNodes] = useState([])
  const [topTechnology, setTopTechnology] = useState(null)
  const [positions, setPositions] = useState([])
  const [arrows, setArrows] = useState(null)

  const renderArrow = (startElement, endElement) => {
    const startElementInfo = startElement.getBoundingClientRect()
    const startElementCenterY = startElementInfo.top + startElementInfo.height / 2
    const startElementCenterX = startElementInfo.left + startElementInfo.width / 2
    const endElementInfo = endElement.getBoundingClientRect()
    const endElementCenterY = endElementInfo.top + endElementInfo.height / 2
    const endElementCenterX = endElementInfo.left + endElementInfo.width / 2
    const arrowWidth = Math.abs(startElementCenterX - endElementCenterX)
    const arrowHeight = Math.abs(startElementCenterY - endElementCenterY)
    return(
      <Arrow width={arrowWidth} height={arrowHeight} startPosition={[startElementCenterX, startElementCenterY]} endPosition={[endElementCenterX, endElementCenterY]}/>
    )
  }

  const arrowHandler = () => {
    const childElements = selectedNodes.map((selectedId) => 
      technologies.find((element) => element.id == selectedId
      )
    )
    const arrows = childElements.map((element) => renderArrow(topTechnology, element))
    setArrows(arrows)
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
