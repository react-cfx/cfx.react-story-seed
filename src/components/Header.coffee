{
  PropTypes
  classnames
  cfx
  Comps
  connect
} = require 'cfx.rw'

{
  header
  h1
} = Comps

{ addTodoState } = require '../actions/index.coffee'

{ initial } = require '../initials/index.coffee'

TodoTextInput = require './TodoTextInput.coffee'

Header = cfx

  handleSave: (text) ->
    { actions } = arguments[arguments.length - 1]
    { addTodoState } = actions
    unless text.length is 0
      addTodoState
        todo: initial.todo text

  render: ->
    header className: 'header'
    ,
      h1 {}
      , 'todos'
    ,
      TodoTextInput
        newTodo: true
        onSave: @handleSave.bind @
        placeholder: 'What needs to be done?'

module.exports = connect(
  ->
  { addTodoState }
  Header
)
