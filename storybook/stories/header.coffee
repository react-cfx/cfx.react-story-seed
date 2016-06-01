RW = require 'react'
Header = require '../../src/components/Header'
{
  storiesOf
  action
} = require '@kadira/storybook'

(storiesOf 'Header', module)

.add 'default view', ->

  RW.createElement 'div'
  , className: 'todoapp'

  ,
    RW.createElement Header.default
    , addTodo: action 'Add Todo'
