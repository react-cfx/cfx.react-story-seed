{
  toActionsTypes
  mergeActionsTypes
} = require 'cfx.redux-types'

module.exports = mergeActionsTypes

  VisibilityFilter: toActionsTypes {
    'SET_VISIBILITY_FILTER'
  }
  VisibilityFilterTypes:
    types: {
      'SHOW_TODO_ALL'
      'SHOW_TODO_ACTIVE'
      'SHOW_TODO_COMPLETED'
    }
