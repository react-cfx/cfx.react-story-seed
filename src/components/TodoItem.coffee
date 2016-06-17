{
  PropTypes
  classnames
  cfx
  Comps
  connect
  c
  Styl
} = require 'cfx.rw'

{
  div
  input
  label
  button
  li
} = Comps

styles = Styl

  todo:
    position: 'relative'
    fontSize: '24px'
    borderBottom: '1px solid #ededed'

    ':last-child':
      borderBottom: 'none'

  todo_editing:
    borderBottom: 'none'
    padding: 0

    ':last-child':
      marginBottom: '-1px'

  toggle:
    textAlign: 'center'
    width: '40px'
    height: 'auto'
    position: 'absolute'
    top: 0
    bottom: 0
    margin: 'auto 0'
    border: 'none'
    '-webkit-appearance': 'none'
    appearance: 'none'

  uncompleted:
    wordBreak: 'break-all'
    padding: '15px 60px 15px 15px'
    marginLeft: '45px'
    display: 'block'
    lineHeight: 1.2
    transition: 'color 0.4s'

  completed:
    color: '#d9d9d9'
    textDecoration: 'line-through'

  destroy:
    display: 'none'
    position: 'absolute'
    top: 0
    right: '10px'
    bottom: 0
    width: '40px'
    height: '40px'
    margin: 'auto 0'
    fontSize: '30px'
    color: '#cc9a9a'
    marginBottom: '11px'
    transition: 'color 0.2s ease-out'

    ':hover':
      color: '#af5b5e'

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
          todoList: true
          text: todo.text
          editing: @state.editing
          onSave: @handleSave.bind @, todo.id, todo.text
      )
      else (
        div {}
        ,
          input
            className: c(
              'toggle'
              styles.toggle
            )
            type: 'checkbox'
            checked: todo.completed
            onChange: -> modifyTodoState
              todo:
                id: todo.id
                completed: not todo.completed
        ,
          label
            className: c(
              styles.uncompleted
              do -> styles.completed if todo.completed
            )
            onDoubleClick: @handleDoubleClick.bind @
          , todo.text
        ,
          button
            className: c(
              'destroy'
              styles.destroy
            )
            onClick: -> removeTodoState
              todoId: todo.id
      )

    li
      className: c(
        classnames
          completed: todo.completed
          editing: @state.editing
        styles.todo
        ( ->
          if @state.editing
            styles.todo_editing
        ).call @
      )
    , element

TodoItem.propTypes =
  todo: PropTypes.object.isRequired

module.exports = TodoItem
