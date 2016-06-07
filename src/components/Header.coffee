{
  PropTypes
  classnames
  cfx
  Comps
} = require 'cfx.rw'

{
  header
  h1
} = Comps

TodoTextInput = require './TodoTextInput.coffee'

Header = cfx

  handleSave: (text) ->
    @props.addTodo text unless text.length is 0

  render: ->
    header className: 'header'
    ,
      h1 {}
      , 'todos'
    ,
      TodoTextInput
        newTodo: true
        onSave: @handleSave.bind @
        placeholder: 'What needs to be done?'

Header.propTypes =
  addTodo: PropTypes.func.isRequired

module.exports = Header
