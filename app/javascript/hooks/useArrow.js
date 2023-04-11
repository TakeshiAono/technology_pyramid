import React, { useState } from "react";
import Arrow from "../components/Arrow";

const useArrow = (technologyRefs) => {
  const bothEdgesPositions = (startElement, endElement) => {
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

  const arrowRect = (top, bottom, left ,right) => {
    const width = Math.abs(left - right)
    const height = Math.abs(top - bottom)
    return {width: width, height: height}
  }

  const getArrowProperties = (startElementId, endElementId) => {
    const startElement = technologyRefs.current.find(technologyRef => technologyRef.current.id == startElementId).current
    const endElement = technologyRefs.current.find(technologyRef => technologyRef.current.id == endElementId).current
    const positions = bothEdgesPositions(startElement, endElement)
    const rect = arrowRect(positions.startPosition.y, positions.endPosition.y, positions.startPosition.x, positions.endPosition.x)
    return {positions: positions, rect: rect}
  }

  return [getArrowProperties]
}

export default useArrow