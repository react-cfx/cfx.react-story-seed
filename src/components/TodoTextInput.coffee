{
  PropTypes
  Component
} = RW = require 'react'
classnames = require 'classnames'

class TodoTextInput extends Component

  constructor: (props, context) ->
    super props, context
    this.state =
      text: @props.text or ''

  handleSubmit: (e) ->
    text = e.target.value.trim()

    if e.which is 13
      @props.onSave text
      if @props.newTodo
        @setState text: ''

  handleChange: (e) ->
    @setState text: e.target.value

  handleBlur: (e) ->
    @props.onSave e.target.value unless @props.newTodo

  render: ->
    RW.createElement 'input'
    ,
      className: classnames
        edit: @props.editing
        'new-todo': @props.newTodo
      type: 'text'
      placeholder: @props.placeholder
      autoFocus: 'true'
      value: @state.text
      onBlur: @handleBlur.bind @
      onChange: @handleChange.bind @
      onKeyDown: @handleSubmit.bind @

TodoTextInput.propTypes =
  onSave: PropTypes.func.isRequired
  text: PropTypes.string
  placeholder: PropTypes.string
  editing: PropTypes.bool
  newTodo: PropTypes.bool

module.exports = TodoTextInput
