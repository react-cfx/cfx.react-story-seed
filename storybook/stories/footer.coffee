{ Comps } = require 'cfx.rw'
{ div } = Comps
Footer = require '../../src/components/Footer.coffee'
{
  storiesOf
  action
} = require '@kadira/storybook'

constants = require '../../src/constants/Visibility.coffee'
{
  SHOW_TODO_ALL
  SHOW_TODO_ACTIVE
  SHOW_TODO_COMPLETED
} = constants.types

(storiesOf 'Footer', module)

.add 'default view', ->

  div className: 'todoapp'
  ,
    Footer
      completedCount: 10
      activeCount: 4
      filter: SHOW_TODO_ALL
      onClearCompleted: action 'onClearCompleted'
      onShow: action 'onShow'

.add 'show completed', ->

  div className: 'todoapp'
  ,
    Footer
      completedCount: 10
      activeCount: 4
      filter: SHOW_TODO_COMPLETED
      onClearCompleted: action 'onClearCompleted'
      onShow: action 'onShow'

.add 'show active', ->

  div className: 'todoapp'
  ,
    Footer
      completedCount: 10
      activeCount: 4
      filter: SHOW_TODO_ACTIVE
      onClearCompleted: action 'onClearCompleted'
      onShow: action 'onShow'
