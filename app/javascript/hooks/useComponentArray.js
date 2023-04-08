import React, { useRef } from "react"

const useComponentArray = (props, Component, callbacks) => {
  const technologyRefs = useRef([])
  const constructComponents = () => {
    return(
      props.map((prop, i) => {
        technologyRefs.current[i] = React.createRef()
        return(
          <>
            <Component
              name={prop.name}
              key={prop.id}
              id={prop.id}
              ref={technologyRefs.current[i]}
              {...callbacks}
            />
          </>
        )
      })
    )
  }
  const components = technologyRefs.current.map((ref) => ref.current)
  return [components, constructComponents]
}

export default useComponentArray