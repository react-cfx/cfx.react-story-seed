{ Comps } = require 'cfx.rw'
{ div } = Comps

{
  Header
} = require './components.coffee'

{
  storiesOf
  action
} = require '@kadira/storybook'

(storiesOf 'Header', module)

.add 'default view', ->

  div className: 'todoapp'
  ,
    Header
      actions:
        addTodoState: action 'addTodoState'
