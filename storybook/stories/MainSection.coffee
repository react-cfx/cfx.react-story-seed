{ Comps } = require 'cfx.rw'
{ div } = Comps

{
  storiesOf
  action
} = require '@kadira/storybook'

{ MainSection } = require './components.coffee'

tagWapper = (tagFunc, Options, props) ->
  _tagFunc = tagFunc Options
  _tagFunc props

_MainSection = (props) ->
  tagWapper MainSection
  ,
    TodoItem:
      actions:
        modifyTodoState: action 'modifyTodoState'
        removeTodoState: action 'removeTodoState'
  , props

getMainSection = (todos) ->

  div className: 'todoapp'
  ,
    _MainSection
      state: { todos }
      actions:
        modifyTodoState: action 'modifyTodoState'
        removeTodoState: action 'removeTodoState'

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

# .add 'some completed', ->
#
#   todoItems = [
#       id: 'one'
#       text: 'Item One'
#       completed: false
#     ,
#       id: 'two'
#       text: 'Item Two'
#       completed: true
#   ]
#
#   getMainSection todoItems
#
# .add 'all completed', ->
#
#   todoItems = [
#       id: 'one'
#       text: 'Item One'
#       completed: true
#     ,
#       id: 'two'
#       text: 'Item Two'
#       completed: true
#   ]
#
#   getMainSection todoItems
