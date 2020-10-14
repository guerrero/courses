// useState: tic tac toe
// Preserve state in localStorage
// http://localhtotalOt:3000/isolated/exercise/04.js

import React from 'react'
import {useLocalStorageState} from '../utils'

function App() {
  return <Game />
}

const empty = null
const x = 'X'
const o = 'O'

function Game() {
  const [currentStep, setCurrentStep] = useLocalStorageState(
    'tic-tac-toe:step',
    0,
  )
  const [history, setHistory] = useLocalStorageState(
    'tic-tac-toe:history',
    createInitialHistory(),
  )

  const currentSquares = history[currentStep]
  const nextValue = calculateNextValue(currentSquares)
  const winner = calculateWinner(currentSquares)
  const status = calculateStatus(currentSquares, nextValue, winner)

  function selectSquare(index) {
    const squareIsEmpty = currentSquares[index] === empty
    if (!winner && squareIsEmpty) {
      let currentHistory = history.slice(0, currentStep + 1)
      let nextSquares = [...currentSquares]
      nextSquares[index] = nextValue

      setHistory([...currentHistory, nextSquares])
      setCurrentStep(currentHistory.length)
    }
  }

  function restart() {
    setHistory(createInitialHistory())
    setCurrentStep(0)
  }

  function createInitialHistory() {
    const totalSquares = 9

    return [Array(totalSquares).fill(empty)]
  }

  const moves = history.map((_, index) => {
    const isCurrentStep = currentStep === index
    const isFirstStep = index === 0
    const message = isFirstStep ? 'Go to game start' : `Go to move #${index}`

    return (
      <li key={index}>
        <button disabled={isCurrentStep} onClick={() => setCurrentStep(index)}>
          {message} {isCurrentStep ? '(current)' : null}
        </button>
      </li>
    )
  })

  return (
    <div className="game">
      <div className="game-board">
        <Board squares={currentSquares} onSquareClick={selectSquare} />
        <button className="restart" onClick={restart}>
          restart
        </button>
      </div>
      <div className="game-info">
        <div>{status}</div>
        {<ol>{moves}</ol>}
      </div>
    </div>
  )
}

function Board({squares, onSquareClick}) {
  function renderSquare(index) {
    return (
      <button className="square" onClick={() => onSquareClick(index)}>
        {squares[index]}
      </button>
    )
  }

  return (
    <div>
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
    </div>
  )
}

function calculateNextValue(squares) {
  const totalX = squares.filter(el => el === x).length
  const totalO = squares.filter(el => el === o).length

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

function calculateStatus(currentSquares, nextValue, winner) {
  if (winner) return `Winner: ${winner}`

  if (!currentSquares.includes(empty)) return `Scratch: Cat's game`

  return `Next player: ${nextValue}`
}

export default App
