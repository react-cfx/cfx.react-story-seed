{ Comps } = require 'cfx.rw'
{ div } = Comps
{ wapper } = require './storyHelper.coffee'

constants = require '../../src/constants/Visibility.coffee'
{
  SHOW_TODO_ALL
  SHOW_TODO_ACTIVE
  SHOW_TODO_COMPLETED
} = constants.types

{
  storiesOf
  action
} = require '@kadira/storybook'

initials = require '../../src/initials/Todos.coffee'

{ Footer } = require '../../src/components/index.coffee'

(storiesOf 'Footer', module)

.add 'default view'
, wapper.lookRoot ->

  div className: 'todoapp'
  ,
    Footer
      activeCount: 0
      completedCount: 0
      filter: SHOW_TODO_ALL
      onShow: action 'onShow'
      clearCompleted: action 'clearCompleted'

.add 'show active'
, wapper.lookRoot ->

  div className: 'todoapp'
  ,
    Footer
      activeCount: 5
      completedCount: 10
      filter: SHOW_TODO_ACTIVE
      onShow: action 'onShow'
      clearCompleted: action 'clearCompleted'

.add 'show completed'
, wapper.lookRoot ->

  div className: 'todoapp'
  ,
    Footer
      activeCount: 5
      completedCount: 10
      filter: SHOW_TODO_COMPLETED
      onShow: action 'onShow'
      clearCompleted: action 'clearCompleted'
