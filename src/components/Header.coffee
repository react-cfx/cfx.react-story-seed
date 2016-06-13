{
  PropTypes
  classnames
  cfx
  Comps
} = require 'cfx.rw'

{
  header
  h1
} = Comps

{ initial } = require '../initials/index.coffee'

Header = (TodoTextInput) -> cfx

  handleSave: (text, props, state) ->
    { actions } = props
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

module.exports = Header
