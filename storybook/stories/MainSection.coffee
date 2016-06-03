RW = require 'react'
MainSection = require '../../src/components/MainSection.coffee'
{
  storiesOf
  action
} = require '@kadira/storybook'

getMainSection = (todos) ->

  actions =
    clearCompleted: action 'clearCompleted'
    completeAll: action 'completeAll'

  RW.createElement 'div'
  , className: 'todoapp'
  ,
    RW.createElement MainSection
    , {
      todos
      actions
    }

(storiesOf 'MainSection', module)

.add 'all active', ->

  todoItems = [
      id: 'one'
      text: 'Item One'
      completed: false
    ,
      id: 'two'
      text: 'Item Two'
      completed: false
  ]

  getMainSection todoItems

.add 'some completed', ->

  todoItems = [
      id: 'one'
      text: 'Item One'
      completed: false
    ,
      id: 'two'
      text: 'Item Two'
      completed: true
  ]

  getMainSection todoItems

.add 'all completed', ->

  todoItems = [
      id: 'one'
      text: 'Item One'
      completed: true
    ,
      id: 'two'
      text: 'Item Two'
      completed: true
  ]

  getMainSection todoItems
