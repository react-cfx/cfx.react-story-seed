RW = require 'react'
Header = require '../../src/components/Header.coffee'
{
  storiesOf
  action
} = require '@kadira/storybook'

(storiesOf 'Header', module)

.add 'default view', ->

  RW.createElement 'div'
  , className: 'todoapp'

  ,
    RW.createElement Header
    , addTodo: action 'Add Todo'
