{
  PropTypes
  cfx
  Comps
  connect
  Styl
} = require 'cfx.rw'
{ classnames } = Styl
{
  div
  input
  label
  button
  li
} = Comps

styles =

  todo: (editing, atLast) ->

    base =
      position: 'relative'
      fontSize: '24px'
      borderBottom:
        if atLast
        then 'none'
        else '1px solid #ededed'

    unless editing
    then base
    else
      Object.assign {}
      , base
      ,
        borderBottom: 'none'
        padding: 0
      ,
        marginBottom: '-1px' if atLast

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
    {
      todo
      atLast
    } = props

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
      style: styles.todo @state.editing
      , atLast
    , element

TodoItem.propTypes =
  todo: PropTypes.object.isRequired

module.exports = TodoItem
