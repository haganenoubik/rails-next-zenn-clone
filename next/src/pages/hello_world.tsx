import type { NextPage } from 'next'
import SimpleButton from '@/components/SimpleButton'

const HelloWorld: NextPage = () => {
  const handleOnClick = () => {
    console.log('hello, Next World!')
  }

  return (
    <>
      <h1>HelloWorld</h1>
      <p>hello, world!</p>
      <SimpleButton onClick={handleOnClick}>クリック</SimpleButton>
    </>
  )
}

export default HelloWorld
