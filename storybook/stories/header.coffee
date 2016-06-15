{ Comps } = require 'cfx.rw'
{ div } = Comps
{ wapper } = require './storyHelper.coffee'

{
  Header
} = require './components.coffee'

{
  storiesOf
  action
} = require '@kadira/storybook'

(storiesOf 'Header', module)

.add 'default view'
, wapper.lookRoot ->

  div className: 'todoapp'
  ,
    Header
      actions:
        addTodoState: action 'addTodoState'
