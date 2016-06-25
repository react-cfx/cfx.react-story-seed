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

  todoContent: (isCompleted) ->
    base =
      wordBreak: 'break-all'
      padding: '15px 60px 15px 15px'
      marginLeft: '45px'
      display: 'block'
      lineHeight: 1.2
      transition: 'color 0.4s'

    unless isCompleted
    then base
    else Object.assign {}
    , base
    ,
      color: '#d9d9d9'
      textDecoration: 'line-through'

  destroy: (isHover) ->
    position: 'absolute'
    top: 0
    right: '10px'
    bottom: 0
    width: '40px'
    height: '40px'
    margin: 'auto 0 11px'
    fontSize: '30px'
    color:
      unless isHover
      then '#cc9a9a'
      else '#af5b5e'
    transition: 'color 0.2s ease-out'

    after:
      content: '×'

TodoItem = (TodoTextInput) -> cfx

  constructor: (props, context) ->
    @state =
      editing: false
      hover:
        todoWrapper: false
        todo: false
        destroy: false

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

    @setState editing: false

  getHover: (stateHover, hoverKey, isHover) ->
    hover = Object.assign {}, stateHover, {}
    hover[hoverKey] = isHover
    hover

  mouseEnter: (hoverKey, dispatch, undefine, e, props) ->
    e.stopPropagation()
    hover = @getHover @state.hover
    , hoverKey, true
    @setState { hover }

  mouseLeave: (hoverKey, dispatch, undefine, e, props) ->
    e.stopPropagation()
    hover = @getHover @state.hover
    , hoverKey, false
    @setState { hover }

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
        div
          className: 'view'
          onMouseEnter: @mouseEnter.bind @, 'todoWrapper'
          onMouseLeave: @mouseLeave.bind @, 'todoWrapper'
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
            style: styles.todoContent todo.completed
            onMouseEnter: @mouseEnter.bind @, 'todo'
            onMouseLeave: @mouseLeave.bind @, 'todo'
          , todo.text
        ,
          ( ->
            console.log @state.hover
            if (
              @state.hover.todoWrapper
            ) and (
              @state.hover.todo or
              @state.hover.destroy
            )
              button
                className: 'destroy'
                style: Styl styles.destroy @state.hover.destroy.enter_leave
                onClick: -> removeTodoState
                  todoId: todo.id
                onMouseEnter: @mouseEnter.bind @, 'destroy'
                onMouseLeave: @mouseLeave.bind @, 'destroy'
          ).call @
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
