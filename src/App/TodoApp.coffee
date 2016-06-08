{
  cfx
  Comps
  connect
} = require 'cfx.rw'
{ section } = Comps
{ action } = require '@kadira/storybook'

constants = require '../constants/Visibility.coffee'
{
  SHOW_TODO_ALL
  SHOW_TODO_ACTIVE
  SHOW_TODO_COMPLETED
} = constants.types

Header = require '../components/Header.coffee'
MainSection = require '../components/MainSection.coffee'

TodoApp = cfx ->

  section
    className: 'todoapp'
  ,
    Header addTodo: action 'Add Todo'
  ,
    MainSection
      todos: [
          id: 'one'
          text: 'Item One'
          completed: false
        ,
          id: 'two'
          text: 'Item Two'
          completed: true
      ]
      actions:
        clearCompleted: action 'clearCompleted'
        completeAll: action 'completeAll'

module.exports = TodoApp
