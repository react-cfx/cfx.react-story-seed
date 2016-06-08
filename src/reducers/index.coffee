{ mergeReduce } = require 'cfx.redux'
{ initialState } = require '../initials/index.coffee'
{
  VisibilityFilter
  VisibilitySettings
  VisibilityContainer
  VisibilityAllToRemove
} = require './Visibility.coffee'
{ Todos } = require './Todos.coffee'

module.exports = mergeReduce {
  VisibilityFilter
  VisibilitySettings
  VisibilityContainer
  VisibilityAllToRemove
  Todos
}
, initialState
