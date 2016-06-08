{ mergeActionsTypes } = require 'cfx.redux-types'
Visibility = require './Visibility.coffee'
Todos = require './Todos.coffee'

module.exports = mergeActionsTypes {
  Visibility
  Todos
}
