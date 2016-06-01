RW = require 'react'
Footer = require '../../src/components/Footer'
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

  RW.createElement 'div'
  , className: 'todoapp'
  ,
    RW.createElement Footer.default
    ,
      completedCount: 10
      activeCount: 4
      filter: SHOW_ALL
      onClearCompleted: action 'onClearCompleted'
      onShow: action 'onShow'

.add 'show completed', ->

  RW.createElement 'div'
  , className: 'todoapp'
  ,
    RW.createElement Footer.default
    ,
      completedCount: 10
      activeCount: 4
      filter: SHOW_COMPLETED
      onClearCompleted: action 'onClearCompleted'
      onShow: action 'onShow'

.add 'show active', ->

  RW.createElement 'div'
  , className: 'todoapp'
  ,
    RW.createElement Footer.default
    ,
      completedCount: 10
      activeCount: 4
      filter: SHOW_ACTIVE
      onClearCompleted: action 'onClearCompleted'
      onShow: action 'onShow'
