echo = -> console.log arguments[0]
{
  cfx
  Comps
} = require 'cfx.rw'
{ section } = Comps
{ action } = require '@kadira/storybook'

constants = require '../constants/Visibility.coffee'
{
  SHOW_TODO_ALL
  SHOW_TODO_ACTIVE
  SHOW_TODO_COMPLETED
} = constants.types

{
  Header
  MainSection
} = require '../connect/index.coffee'
TodoTextInput = require '../components/TodoTextInput.coffee'

TodoApp = cfx (props, state) ->

  section className: 'todoapp'
  ,
    Header()
  ,
    MainSection()

module.exports = TodoApp
