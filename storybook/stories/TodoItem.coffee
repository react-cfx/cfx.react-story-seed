RW = require 'react';
TodoItem = require '../../src/components/TodoItem.coffee'
{
  storiesOf
  action
} = require '@kadira/storybook'

getItem = (todo) ->

  RW.createElement 'div'
  , className: 'todoapp'

  ,
    RW.createElement 'div'
    , className: 'todo-list'

    ,
      RW.createElement TodoItem
      ,
        todo: todo
        editTodo: action 'editTodo'
        deleteTodo: action 'deleteTodo'
        completeTodo: action 'completeTodo'

(storiesOf 'TodoItem', module)

.add 'not completed', ->

  todo =
    id: 'the-id'
    text: 'Hello Todo'
    completed: false

  getItem todo

.add 'completed', ->

  todo =
    id: 'the-id'
    text: 'Hello Todo'
    completed: true

  getItem todo
