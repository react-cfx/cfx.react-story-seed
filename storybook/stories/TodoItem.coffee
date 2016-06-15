{ Comps } = require 'cfx.rw'
{ div } = Comps
{ wapper } = require './storyHelper.coffee'

{ TodoItem } = require './components.coffee'

{
  storiesOf
  action
} = require '@kadira/storybook'

getItem = (todo) ->

  div className: 'todoapp'
  ,
    div className: 'todo-list'
    ,
      TodoItem
        todo: todo
        actions:
          modifyTodoState: action 'modifyTodoState'
          removeTodoState: action 'removeTodoState'

(storiesOf 'TodoItem', module)

.add 'not completed'
, wapper.lookRoot ->

  todo =
    id: 'the-id'
    text: 'Hello Todo'
    completed: false

  getItem todo

.add 'completed'
, wapper.lookRoot ->

  todo =
    id: 'the-id'
    text: 'Hello Todo'
    completed: true

  getItem todo
