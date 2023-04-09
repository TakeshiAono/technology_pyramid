import React, { useEffect, useState, useRef, forwardRef } from "react"

const Technology = forwardRef((props, technologyRef) => {
  useEffect(() => {
    if (props.selectedNodes.includes(props.id.toString())) {
      technologyRef.current.style.border = 'dashed'
    }else{
      technologyRef.current.style.border = 'solid'
    }
    if (props.topTechnology?.id == props.id) {
      technologyRef.current.style.borderColor  = "red"
    }
  })

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
