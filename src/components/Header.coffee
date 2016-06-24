{
  PropTypes
  cfx
  Comps
  Styl
} = require 'cfx.rw'

{
  header
  h1
} = Comps

{ initial } = require '../initials/index.coffee'

styles =

  appTitle: do ->

    textRendering = 'optimizeLegibility'

    position: 'absolute'
    top: '-155px'
    width: '100%'
    fontSize: '100px'
    fontWeight: 100
    textAlign: 'center'
    color: 'rgba(175, 47, 47, 0.15)'
    WebkitTextRendering: textRendering
    MozTextRendering: textRendering
    TextRendering: textRendering

  addTodo:

    inputPlaceholder:
      fontStyle: 'italic'
      fontWeight: 300
      color: '#e6e6e6'

Header = (TodoTextInput) -> cfx

  handleSave: (text, props, state) ->
    { actions } = props
    { addTodoState } = actions
    unless text.length is 0
      addTodoState
        todo: initial.todo text

  render: ->

    header {}
    ,
      h1
        style: styles.appTitle
      , 'todos'
    ,
      TodoTextInput
        styles:
          input: styles.addTodo
        newTodo: true
        onSave: @handleSave.bind @
        placeholder: 'What needs to be done?'

module.exports = Header
