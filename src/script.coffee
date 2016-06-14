# require 'todomvc-app-css/index.css'
require './style.styl'

{ render } = require 'react-dom'
TodoApp = require './App/index.coffee'

{
  Presets
  LookRoot
  cfxify
} = require 'cfx.rw'

LookRoot = cfxify LookRoot
config = Presets['react-dom']

render (
  LookRoot { config }
  ,
    TodoApp {}
), document.getElementById 'app'
