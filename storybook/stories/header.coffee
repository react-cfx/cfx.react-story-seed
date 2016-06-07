{ Comps } = require 'cfx.rw'
{ div } = Comps
Header = require '../../src/components/Header.coffee'
{
  storiesOf
  action
} = require '@kadira/storybook'

(storiesOf 'Header', module)

.add 'default view', ->

  div className: 'todoapp'
  ,
    Header addTodo: action 'Add Todo'
