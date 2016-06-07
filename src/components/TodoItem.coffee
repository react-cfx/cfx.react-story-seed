{
  PropTypes
  classnames
  cfx
  Comps
} = require 'cfx.rw'

{
  div
  input
  label
  button
  li
} = Comps

TodoTextInput = require './TodoTextInput.coffee'

TodoItem = cfx

  constructor: (props, context) ->
    @state = editing: false

  handleDoubleClick: ->
    @setState editing: true

  handleSave: (id, text) ->
    if text.length is 0
      @props.deleteTodo id
    else
      @props.editTodo id, text
    @state = editing: false

  render: ->
    {
      todo
      completeTodo
      deleteTodo
    } = @props

    element =
      if @state.editing
      then (
        TodoTextInput
          text: todo.text
          editing: @state.editing
          onSave: @handleSave.bind @, todo.id, todo.text
      )
      else (
        div className: 'view'
        ,
          input
            className: 'toggle'
            type: 'checkbox'
            checked: todo.completed
            onChange: -> completeTodo todo.id
        ,
          label
            onDoubleClick: @handleDoubleClick.bind @
          , todo.text
        ,
          button
            className: 'destroy'
            onClick: -> deleteTodo todo.id
      )

    li
      className: classnames
        completed: todo.completed
        editing: @state.editing
    , element

TodoItem.propTypes =
  todo: PropTypes.object.isRequired
  editTodo: PropTypes.func.isRequired
  deleteTodo: PropTypes.func.isRequired
  completeTodo: PropTypes.func.isRequired

module.exports = TodoItem
