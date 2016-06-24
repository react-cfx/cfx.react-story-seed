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

  toggle: (isCompleted) ->

    textAlign: 'center'
    width: '40px'
    height: 'auto'
    position: 'absolute'
    top: 0
    bottom: 0
    margin: 'auto 0'
    border: 'none'
    WebkitAppearance: 'none'
    appearance: 'none'

    after:
      content:
        unless isCompleted
        then """
          url(\"data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' width='40' height='40' viewBox='-10 -18 100 135'><circle cx='50' cy='50' r='50' fill='none' stroke='#ededed' stroke-width='3'/></svg>\")
        """
        else """
          url(\"data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' width='40' height='40' viewBox='-10 -18 100 135'><circle cx='50' cy='50' r='50' fill='none' stroke='#bddad5' stroke-width='3'/><path fill='#5dc2af' d='M72 25L42 71 27 56l-4 4 20 20 34-52z'/></svg>\")
        """

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
            style: Styl styles.toggle todo.completed
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
