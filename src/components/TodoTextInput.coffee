{
  PropTypes
  classnames
  cfx
  Comps
  c
  Styl
} = require 'cfx.rw'
{ input } = Comps

styles = Styl

  newTodo:
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
    '-webkit-font-smoothing': 'antialiased'
    '-moz-osx-font-smoothing': 'grayscale'

  whithOutEdit:
    padding: '16px 16px 16px 60px'
    border: 'none'
    background: 'rgba(0, 0, 0, 0.003)'
    boxShadow: 'inset 0 -2px 1px rgba(0,0,0,0.03)'

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
      className: c(
        do -> styles.whithOutEdit unless props.edit
        do -> styles.newTodo
        do -> props.styles.input if props.styles?.input?
      )
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
