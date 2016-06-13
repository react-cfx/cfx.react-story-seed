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

TodoItem = (TodoTextInput) -> cfx

  constructor: (props, context) ->
    @state = editing: false

  handleDoubleClick: ->
    @setState editing: true

  handleSave: (id, oldText, newText, props) ->
    {
      modifyTodoState
      removeTodoState
    } = props.actions

    unless newText.length is 0
      unless newText is oldText
        modifyTodoState
          todo: {
            id
            text: newText
          }
      else
        @setState editing: false
    else
      removeTodoState
        todoId: id

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
                completed: not todo.completed
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

TodoItem.propTypes =
  todo: PropTypes.object.isRequired

module.exports = TodoItem
