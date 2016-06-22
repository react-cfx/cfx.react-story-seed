{
  cfx
  Comps
} = require 'cfx.rw'
{ section } = Comps

{
  Header
  MainSection
} = require '../connect/index.coffee'

TodoApp = cfx (props, state) ->

  section className: 'todoapp'
  ,
    Header()
  ,
    MainSection()

module.exports = TodoApp
