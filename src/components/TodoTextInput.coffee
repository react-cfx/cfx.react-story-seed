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
      style: do -> Styl props.styles.input if props.styles?.input?
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
  # style: PropTypes.object.isRequired
  text: PropTypes.string
  placeholder: PropTypes.string
  editing: PropTypes.bool
  newTodo: PropTypes.bool

module.exports = TodoTextInput
