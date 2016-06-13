{ Comps } = require 'cfx.rw'
{ div } = Comps
{ Footer } = require '../../src/components/index.coffee'

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

(storiesOf 'Footer', module)

.add 'default view', ->

  div className: 'todoapp'
  ,
    Footer
      activeCount: 0
      completedCount: 0
      filter: SHOW_TODO_ALL
      onShow: action 'onShow'
      clearCompleted: action 'clearCompleted'

.add 'show active', ->

  div className: 'todoapp'
  ,
    Footer
      activeCount: 5
      completedCount: 10
      filter: SHOW_TODO_ACTIVE
      onShow: action 'onShow'
      clearCompleted: action 'clearCompleted'

.add 'show completed', ->

  div className: 'todoapp'
  ,
    Footer
      activeCount: 5
      completedCount: 10
      filter: SHOW_TODO_COMPLETED
      onShow: action 'onShow'
      clearCompleted: action 'clearCompleted'
