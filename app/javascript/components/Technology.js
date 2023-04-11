import React, { useEffect, useState, useRef, forwardRef } from "react"

const Technology = forwardRef((props, technologyRef) => {
  useEffect(() => {
    if (props.selectedNodeIds.includes(props.id.toString())) {
      technologyRef.current.style.border = 'dashed'
    }else{
      technologyRef.current.style.border = 'solid'
    }
    if (props.topTechnologyId == props.id) {
      technologyRef.current.style.borderColor  = "red"
    }
  }, [props.topTechnologyId, props.selectedNodeIds])

  return(
    <>
      <div ref={technologyRef}
        className='technology'
        id={props.id}
        style={{cursor: "pointer"}}
      >
      {props.name}
      </div>
    </>
  )
})

export default Technology
