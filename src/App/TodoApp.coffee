echo = -> console.log arguments[0]
{
  cfx
  Comps
} = require 'cfx.rw'
{ section } = Comps
{ action } = require '@kadira/storybook'

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
