import React, { useEffect, useRef, useState} from "react"
import "./Arrow.css"

const Arrow = (props) => {
  console.log(props)
  const [startPosition, setStartPosition] = useState(props.startPosition)
  const [endPosition, setEndPosition] = useState(props.endPosition)
  const [color, setColor] = useState("black")
  const [stroke, setStroke] = useState("5")
  const svgRef = useRef(null)
  const lineRef = useRef(null)

  useEffect(() => {
    svgRef.current.style.top = startPosition[1]
    svgRef.current.style.left = startPosition[0]
  }, [])
  

  return(
    <>
      {console.log(startPosition)}
      {console.log(endPosition)}
      <svg ref={svgRef} width={props.width} height={props.height} xmlns="http://www.w3.org/2000/svg">
        <line ref={lineRef} x1="1" y1="1" x2="100%" y2="100%" stroke={color} strokeWidth={stroke}/>
      </svg>
    </>
  )
}

export default Arrow
