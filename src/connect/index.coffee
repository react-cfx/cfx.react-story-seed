{ connect } = require 'cfx.rw'

{
  addTodoState
  modifyTodoState
  removeTodoState
} = require '../actions/index.coffee'

Components = require '../components/index.coffee'

TodoTextInput = Components.TodoTextInput

TodoItem = connect(
  ->
  {
    modifyTodoState
    removeTodoState
  }
  Components.TodoItem(
    Components.TodoTextInput
  )
)

Header = connect(
  ->
  { addTodoState }
  Components.Header(
    Components.TodoTextInput
  )
)

Footer = Components.Footer

MainSection = connect(
  (state) ->
    todos: state.todoApp.Todos
  {
    modifyTodoState
    removeTodoState
  }
  Components.MainSection(
    TodoItem
    Footer
  )
)

module.exports = {
  TodoTextInput
  TodoItem
  Header
  Footer
  MainSection
}
