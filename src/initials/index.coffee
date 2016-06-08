Visibility = require './Visibility.coffee'
Todos = require './Todos.coffee'

initial = Object.assign {}
, Visibility.initial
, Todos.initial

initialState = Object.assign {}
, Visibility.initialState
, Todos.initialState

module.exports = {
  initial
  initialState
}
