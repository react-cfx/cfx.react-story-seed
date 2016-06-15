{ mergeReduce } = require 'cfx.redux'
{ initialState } = require '../initials/index.coffee'
{ Todos } = require './Todos.coffee'

module.exports = mergeReduce {
  Todos
}
, initialState
