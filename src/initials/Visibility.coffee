constants = require '../constants/Visibility.coffee'
{
  SHOW_TODO_ACTIVE
} = constants.types

initial =
  VisibilityFilter: SHOW_TODO_ACTIVE

module.exports = {
  initial
  initialState: initial
}
