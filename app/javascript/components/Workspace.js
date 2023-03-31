import React, { useEffect, useState } from "react"
import Technology from "./Technology";
import './Workspace.css'

const Workspace = (props) => {
  const [anySelect, setAnySelect] = useState(false)
  const [selectedNodes, setSelectedNodes] = useState([])

  const technologiesConstructor = () => {
    return(
      props.technologies.map((technology) => {
        return(
          <Technology 
            name={technology.name}
            key={technology.id}
            id={technology.id}
            selectedNodes={selectedNodes}
            setSelectedNodes={setSelectedNodes}
          />
        )
      })
    )
  }

  return(
    <div className="workspace" onMouseDown={() =>{setSelectedNodes([])}}>
      {technologiesConstructor()}
    </div>
  )
}

export default Workspace