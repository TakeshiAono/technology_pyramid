import React, { useRef, useState } from "react";

const useTechnology = (topTechnologyId, setTopTechnologyId, selectedNodeIds, setSelectedNodeIds) => {
  const beforeMovePosition = useRef<{x: number, y: number}>()
  const afterMovePosition = useRef<{x: number, y: number}>()

  const mousePosition = (evt: React.MouseEvent): {x: number, y: number} => {
    return {x: evt.pageX, y: evt.pageY}
  }

  const liftUpTechnology = (evt: React.MouseEvent) => {
    const techElement= evt.target as HTMLElement
    techElement.style.position = 'absolute'
    beforeMovePosition.current = mousePosition(evt)
  }

  const liftDown = (evt: React.MouseEvent) => {
    const target = evt.target as HTMLElement
    const nativeEvent = evt.nativeEvent as MouseEvent
    afterMovePosition.current = mousePosition(nativeEvent)
    const differentialMousePosX = afterMovePosition.current.x - beforeMovePosition.current.x
    const differentialMousePosY = afterMovePosition.current.y - beforeMovePosition.current.y
    target.style.left = (nativeEvent.pageX - nativeEvent.offsetX + differentialMousePosX) + "px"
    target.style.top = (nativeEvent.pageY - nativeEvent.offsetY + differentialMousePosY) + "px"
  };

  const selectTechnology = (e: React.MouseEvent): void => {
    const target = e.target as HTMLElement
    if (e.ctrlKey) {
      if (!selectedNodeIds.includes(target.id)) {setSelectedNodeIds([...selectedNodeIds, target.id])}
    }
    else if(e.shiftKey) {
      topTechnologySelect(e)
    }
    else {
      setSelectedNodeIds([target.id])
      setTopTechnologyId(null)
    }
  }

  const topTechnologySelect = (e: React.MouseEvent) => {
    const target = e.target as HTMLElement
    setTopTechnologyId(target.id)
    setSelectedNodeIds(selectedNodeIds.filter((value) => value !== target.id))
  }

  return [liftUpTechnology, liftDown, selectTechnology]
}

export default useTechnology
