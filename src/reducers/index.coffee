{ mergeReduce } = require 'cfx.redux'
{ initialState } = require '../initials/index.coffee'
{
  VisibilityFilter
} = require './Visibility.coffee'
{ Todos } = require './Todos.coffee'

module.exports = mergeReduce {
  VisibilityFilter
  Todos
}
, initialState
