{
  PropTypes
  classnames
  cfx
  Comps
  connect
} = require 'cfx.rw'

{
  div
  input
  label
  button
  li
} = Comps

TodoTextInput = require './TodoTextInput.coffee'
{
  modifyTodoState
  removeTodoState
} = require '../actions/index.coffee'

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

  render: (props, state) ->
    { todo } = props
    {
      modifyTodoState
      removeTodoState
    } = props.actions

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
            onChange: -> modifyTodoState
              todo:
                id: todo.id
                completed: !todo.completed
        ,
          label
            onDoubleClick: @handleDoubleClick.bind @
          , todo.text
        ,
          button
            className: 'destroy'
            onClick: -> removeTodoState
              todoId: todo.id
      )

    li
      className: classnames
        completed: todo.completed
        editing: @state.editing
    , element

# TodoItem.propTypes =
#   todo: PropTypes.object.isRequired
#   editTodo: PropTypes.func.isRequired
#   deleteTodo: PropTypes.func.isRequired
#   completeTodo: PropTypes.func.isRequired

module.exports = connect(
  ->
  {
    modifyTodoState
    removeTodoState
  }
  TodoItem
)
