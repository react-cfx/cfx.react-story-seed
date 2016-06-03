{
  PropTypes
  Component
} = RW = require 'react'
classnames = require 'classnames'
TodoTextInput = (
  require './TodoTextInput.js'
).default

class TodoItem extends Component

  constructor: (props, context) ->
    super props, context
    @state = editing: false

  handleDoubleClick: ->
    @setState editing: true

  handleSave: (id, text) ->
    if text.length is 0
      @props.deleteTodo id
    else
      @props.editTodo id, text
    @setState editing: false

  render: ->
    {
      todo
      completeTodo
      deleteTodo
    } = @props

    console.log todo

    if @state.editing
      element =
        RW.createElement TodoTextInput
        ,
          text: todo.text
          editing: @state.editing
          onSave: (text) -> @handleSave todo.id, text
    else
      element =
        RW.createElement 'div'
        , className: 'view'
        ,
          RW.createElement 'input'
          ,
            className: 'toggle'
            type: 'checkbox'
            checked: todo.completed
            onChange: -> completeTodo todo.id
        ,
          RW.createElement 'label'
          , onDoubleClick: @handleDoubleClick.bind @
          , todo.text
        ,
          RW.createElement 'button'
          ,
            className: 'destroy'
            onClick: -> deleteTodo todo.id

    RW.createElement 'li'
    ,
      className: classnames
        completed: todo.completed
        editing: @state.editing
    ,
      RW.createElement 'div'
      , className: 'view'
      ,
        RW.createElement 'input'
        ,
          className: 'toggle'
          type: 'checkbox'
          checked: todo.completed
          onChange: -> completeTodo todo.id
      ,
        RW.createElement 'label'
        ,
          onDoubleClick: @handleDoubleClick.bind @
        , todo.text
      ,
        RW.createElement 'button'
        ,
          className: 'destroy'
          onClick: -> deleteTodo todo.id

TodoItem.propTypes =
  todo: PropTypes.object.isRequired
  editTodo: PropTypes.func.isRequired
  deleteTodo: PropTypes.func.isRequired
  completeTodo: PropTypes.func.isRequired

module.exports = TodoItem
