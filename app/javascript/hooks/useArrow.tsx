import React, { useState } from "react";
import Arrow from "../components/Arrow";

type ArrowPos = {
  startPosition: {
    x: number,
    y: number
  },
  endPosition: {
    x: number,
    y: number
  }
}

type ArrowRect = {
  width: number,
  height: number
}

type ArrowPosRect = {
  positions: ArrowPos,
  rect: ArrowRect
}

const useArrow = (technologyRefs): [(startElementId: string, endElementId: string) => ArrowPosRect] => {
  const getArrowProperties = (startElementId: string, endElementId: string) => {
    const startElement = technologyRefs.current.find(technologyRef => technologyRef.current.id === startElementId).current
    const endElement = technologyRefs.current.find(technologyRef => technologyRef.current.id === endElementId).current
    const positions: ArrowPos = bothEdgesPositions(startElement, endElement)
    const rect: ArrowRect = arrowRect(positions.startPosition.y, positions.endPosition.y, positions.startPosition.x, positions.endPosition.x)
    return {positions: positions, rect: rect}
  }

  const bothEdgesPositions = (startElement: HTMLElement, endElement: HTMLElement): ArrowPos => {
    const startElementInfo = startElement.getBoundingClientRect()
    const startElementCenterY = startElementInfo.top + startElementInfo.height / 2
    const startElementCenterX = startElementInfo.left + startElementInfo.width / 2

    const endElementInfo = endElement.getBoundingClientRect()
    const endElementCenterY = endElementInfo.top + endElementInfo.height / 2
    const endElementCenterX = endElementInfo.left + endElementInfo.width / 2

    return(
      {
        startPosition: {x: startElementCenterX, y: startElementCenterY},
        endPosition: {x: endElementCenterX, y: endElementCenterY}
      }
    )
  }

  const arrowRect = (top: number, bottom: number, left: number ,right: number): ArrowRect => {
    const width = Math.abs(left - right)
    const height = Math.abs(top - bottom)
    return {width: width, height: height}
  }

  return [getArrowProperties]
}

export {useArrow, ArrowPosRect}