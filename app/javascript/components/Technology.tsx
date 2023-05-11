import React, { useEffect, forwardRef } from "react"

type TechnologyProps = {
  id: string;
  name: string;
  topTechnologyId: string | null;
  selectedNodeIds: string[];
};
//　TODO useRefを使わずにworkspaceで持っているselectIds: number[]の中に自分のidがある場合は色を変えるという風にすればいい
const Technology = forwardRef<HTMLDivElement, TechnologyProps>((props: TechnologyProps, technologyRef: React.RefObject<HTMLDivElement>) => {
  useEffect(() => {
    if (technologyRef.current) {
      if (props.selectedNodeIds.includes(props.id.toString())) {
        technologyRef.current.style.border = 'dashed'
      } else {
        technologyRef.current.style.border = 'solid'
      }
      if (props.topTechnologyId == props.id) {
        technologyRef.current.style.borderColor  = "red"
      }
    }
  }, [props.topTechnologyId, props.selectedNodeIds, technologyRef])

  return (
    <>
      <div ref={technologyRef}
        className='technology'
        id={props.id}
        style={{ cursor: "pointer" }}
      >
        {props.name}
      </div>
    </>
  )
})

export default Technology
