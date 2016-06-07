{ Comps } = require 'cfx.rw'
{ div } = Comps
Footer = require '../../src/components/Footer.coffee'
{
  storiesOf
  action
} = require '@kadira/storybook'
{
  SHOW_ALL
  SHOW_COMPLETED
  SHOW_ACTIVE
} = require '../../src/constants/TodoFilters'

(storiesOf 'Footer', module)

.add 'default view', ->

  div className: 'todoapp'
  ,
    Footer
      completedCount: 10
      activeCount: 4
      filter: SHOW_ALL
      onClearCompleted: action 'onClearCompleted'
      onShow: action 'onShow'

.add 'show completed', ->

  div className: 'todoapp'
  ,
    Footer
      completedCount: 10
      activeCount: 4
      filter: SHOW_COMPLETED
      onClearCompleted: action 'onClearCompleted'
      onShow: action 'onShow'

.add 'show active', ->

  div className: 'todoapp'
  ,
    Footer
      completedCount: 10
      activeCount: 4
      filter: SHOW_ACTIVE
      onClearCompleted: action 'onClearCompleted'
      onShow: action 'onShow'
