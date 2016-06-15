{ Comps } = require 'cfx.rw'
{ div } = Comps

{
  storiesOf
  action
} = require '@kadira/storybook'

{ MainSection } = require './components.coffee'
{ wapper } = require './storyHelper.coffee'

getMainSection = (todos) ->

  actions =
    modifyTodoState: action 'modifyTodoState'
    removeTodoState: action 'removeTodoState'

  div className: 'todoapp'
  ,
    MainSection
      state: { todos }
      actions: actions
      _Options:
        TodoItem:
          actions: actions

(storiesOf 'MainSection', module)

.add 'all active'
, wapper.lookRoot ->

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

.add 'some completed'
, wapper.lookRoot ->

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

.add 'all completed'
, wapper.lookRoot ->

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
