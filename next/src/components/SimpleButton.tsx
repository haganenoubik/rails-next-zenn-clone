import React, { ReactNode } from 'react'

type SimpleButtonProps = {
  children: ReactNode
  onClick: () => void
}

const SimpleButton = (props: SimpleButtonProps) => {
  const { children, onClick } = props
  return <button onClick={onClick}>{children}</button>
}

export default SimpleButton
