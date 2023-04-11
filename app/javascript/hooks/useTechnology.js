import React, { useRef, useState } from "react";

const useTechnology = () => {
  const [selectedNodes, setSelectedNodes] = useState([])
  const [topTechnology, setTopTechnology] = useState(null)
  const [selectedNodeIds, setSelectedNodeIds] = useState([])
  const [topTechnologyId, setTopTechnologyId] = useState(null)
  const beforeMovePosition = useRef()
  const afterMovePosition = useRef()
  const technologyRefs = useRef([])

    // useEffect(() => {
  //   if (selectedNodes.includes(clickedTechnologyId)) {
  //     technologyRef.current.style.border = 'dashed'
  //   }else{
  //     technologyRef.current.style.border = 'solid'
  //   }
  //   if (props.topTechnology?.id == props.id) {
  //     technologyRef.current.style.borderColor  = "red"
  //   }
  // }, [topTechnology, selectedNodes])

  const mousePosition = (evt) => {
    return {x: evt.pageX, y: evt.pageY}
  }

  const liftUpTechnology = (evt) => {
    const techElement = evt.target
    techElement.style.position = 'absolute'
    beforeMovePosition.current = mousePosition(evt)
  }

  const liftDown = (evt) => {
    afterMovePosition.current = mousePosition(evt)
    const differentialMousePosX = afterMovePosition.current.x - beforeMovePosition.current.x
    const differentialMousePosY = afterMovePosition.current.y - beforeMovePosition.current.y
    evt.target.style.left = (evt.pageX - evt.nativeEvent.offsetX + differentialMousePosX) + "px"
    evt.target.style.top = (evt.pageY - evt.nativeEvent.offsetY + differentialMousePosY) + "px"
  }

  const selectTechnology = (e) => {
    if (e.ctrlKey) {
      if (!selectedNodeIds.includes(e.target.id)) {setSelectedNodeIds([...selectedNodeIds, e.target.id])}
    }
    else if(e.shiftKey) {
      topTechnologySelect(e)
    }
    else {
      setSelectedNodes([e.target.id])
      setTopTechnology(null)
    }
  }

  const topTechnologySelect = (e) => {
    // console.log('technologyRefs',technologyRefs.current[0])
    setTopTechnologyId(e.target.id)
    setSelectedNodeIds(selectedNodeIds.filter((value) => value !== e.target.id))
    console.log(selectedNodeIds)
  }

  return [technologyRefs, topTechnologyId, setTopTechnologyId, selectedNodeIds, setSelectedNodeIds, liftUpTechnology, liftDown, selectTechnology]
}

export default useTechnology
