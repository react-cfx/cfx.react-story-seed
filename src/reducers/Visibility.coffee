{ reduxActions } = require 'cfx.redux-actions'
{
  handleAction
} = reduxActions

constants = require '../constants/Visibility.coffee'
{
  SET_VISIBILITY_FILTER
} = constants.types

VisibilityFilter = handleAction(
  SET_VISIBILITY_FILTER
  next: (state, action) -> action.payload
  throw: (state, action) ->
    throw new Error {
      state
      action
    }
)

module.exports = {
  VisibilityFilter
}
