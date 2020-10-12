// useEffect: persistent state
// Custom hook
// http://localhost:3000/isolated/exercise/02.js

import React, {useState, useEffect} from 'react'

function useLocalStorageState(itemName, initialValue) {
  const [value, setValue] = useState(
    () => window.localStorage.getItem(itemName) || initialValue,
  )

  useEffect(() => {
    window.localStorage.setItem(itemName, value)
  }, [value, itemName])

  return [value, setValue]
}

function Greeting({initialName = ''}) {
  const [name, setName] = useLocalStorageState('name', initialName)

  function handleChange(event) {
    setName(event.target.value)
  }

  return (
    <div>
      <form>
        <label htmlFor="name">Name: </label>
        <input value={name} onChange={handleChange} id="name" />
      </form>
      {name ? <strong>Hello {name}</strong> : 'Please type your name'}
    </div>
  )
}

function App() {
  return <Greeting />
}

export default App
