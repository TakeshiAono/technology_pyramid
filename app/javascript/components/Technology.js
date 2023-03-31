import React, { useEffect, useState, useRef } from "react"
import SelectNode from "./SelectNode";

const Technology = (props) => {
  const technologyRef = useRef(null)
  const [height, setHeight] = useState(0)
  const [width, setWidth] = useState(0)
  const [selected, setSelected] = useState(false)

  useEffect(() => {
    if (props.selectedNodes.includes(props.id.toString())) {
      technologyRef.current.style.border = 'dashed'
    }else{
      technologyRef.current.style.border = 'solid'
    }
  })

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
        props.setSelectedNodes([...props.selectedNodes, e.target.id])
        e.target.style.border = "dashed"
      }else{
        props.setSelectedNodes([])
        e.target.style.border = "dashed"
      }
  }

  return(
    <>
      <div ref={technologyRef} className='technology' id={props.id} 
        onMouseDown={(e) =>{
          haveNode(e)
          selectHandler(e)
          e.stopPropagation()
        }} style={{cursor: "pointer"}}
      >
        {props.name}
      </div>
    </>
  )
}

export default Technology