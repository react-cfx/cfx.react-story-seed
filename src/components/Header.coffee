{
  PropTypes
  Component
} = RW = require 'react'
TodoTextInput = require './TodoTextInput.coffee'

class Header extends Component

  handleSave: (text) ->
    @props.addTodo text unless text.length is 0

  render: ->
    RW.createElement 'header'
    , className: 'header'
    ,
      RW.createElement 'h1'
      , {}
      , 'todos'
    ,
      RW.createElement TodoTextInput
      ,
        newTodo: true
        onSave: @handleSave.bind @
        placeholder: 'What needs to be done?'

Header.propTypes =
  addTodo: PropTypes.func.isRequired

module.exports = Header;
