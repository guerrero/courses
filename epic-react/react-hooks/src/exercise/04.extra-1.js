// useState: tic tac toe
// Preserve state in localStorage
// http://localhtotalOt:3000/isolated/exercise/04.js

import React, {useEffect, useState} from 'react'

const empty = null
const x = 'X'
const o = 'O'

function Board() {
  const [squares, setSquares] = useState(() => {
    const state = window.localStorage.getItem('squares')
    return state ? JSON.parse(state) : createEmptySquares()
  })

  useEffect(() => {
    window.localStorage.setItem('squares', JSON.stringify(squares))
  }, [squares])

  const winner = calculateWinner(squares)
  const nextValue = calculateNextValue(squares)
  const status = calculateStatus(squares, winner, nextValue)

  function handleSquareClick(index) {
    const squareIsEmpty = squares[index] === empty

    if (!winner && squareIsEmpty) {
      let nextSquareState = [...squares]
      nextSquareState[index] = nextValue
      setSquares(nextSquareState)
    }
  }

  function handleRestartClick() {
    setSquares(createEmptySquares())
  }

  function renderSquare(index) {
    return (
      <button className="square" onClick={() => handleSquareClick(index)}>
        {squares[index]}
      </button>
    )
  }

  return (
    <div>
      <div className="status">{status}</div>
      <div className="board-row">
        {renderSquare(0)}
        {renderSquare(1)}
        {renderSquare(2)}
      </div>
      <div className="board-row">
        {renderSquare(3)}
        {renderSquare(4)}
        {renderSquare(5)}
      </div>
      <div className="board-row">
        {renderSquare(6)}
        {renderSquare(7)}
        {renderSquare(8)}
      </div>
      <button className="restart" onClick={handleRestartClick}>
        Restart
      </button>
    </div>
  )
}

function Game() {
  return (
    <div className="game">
      <div className="game-board">
        <Board />
      </div>
    </div>
  )
}

function App() {
  return <Game />
}

function calculateNextValue(squares) {
  const totalX = squares.filter(square => square === x).length
  const totalO = squares.filter(square => square === o).length

  if (totalX === totalO) return x

  return o
}

function calculateWinner(squares) {
  const winnerCombinations = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [6, 4, 2],
  ]

  for (let i = 0; i < winnerCombinations.length; i++) {
    const [a, b, c] = winnerCombinations[i]

    if (squares[a] && squares[a] === squares[b] && squares[a] === squares[c]) {
      return squares[a]
    }
  }

  return null
}

function calculateStatus(squares, winner, nextValue) {
  if (winner) return `Winner: ${winner}`

  if (!squares.includes(empty)) return `Scratch: Cat's game`

  return `Next player: ${nextValue}`
}

function createEmptySquares() {
  const totalSquares = 9

  return Array(totalSquares).fill(empty)
}

export default App
