{
  PropTypes
  cfx
  Comps
  Styl
} = require 'cfx.rw'
{
  classnames
  c
} = Styl
{ input } = Comps

styles =

  input: (propsStyle) ->
    return unless propsStyle or propsStyle.input
    propsStyle.input

  newTodo: (newTodo, editing) ->

    return unless newTodo

    base =
      position: 'relative'
      margin: 0
      width: '100%'
      fontSize: '24px'
      fontFamily: 'inherit'
      fontWeight: 'inherit'
      lineHeight: '1.4em'
      border: 0
      color: 'inherit'
      padding: '6px'
      border: '1px solid #999'
      boxShadow: 'inset 0 -1px 5px 0 rgba(0, 0, 0, 0.2)'
      boxSizing: 'border-box'
      WebkitFontSmoothing: 'antialiased'
      MozOsxFontSmoothing: 'grayscale'

    withoutEdit =
      padding: '16px 16px 16px 60px'
      border: 'none'
      background: 'rgba(0, 0, 0, 0.003)'
      boxShadow: 'inset 0 -2px 1px rgba(0,0,0,0.03)'

    unless editing
      Object.assign {}
      , base
      , withoutEdit
    else base

TodoTextInput = cfx

  constructor: (props, state) ->
    @state =
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

  render: (props, state) ->

    input

      style: [
        Styl styles.input props.styles
        # Styl styles.newTodo props.newTodo, props.editing
      ]
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
  styles: PropTypes.object.isRequired
  text: PropTypes.string
  placeholder: PropTypes.string
  editing: PropTypes.bool
  newTodo: PropTypes.bool

module.exports = TodoTextInput
