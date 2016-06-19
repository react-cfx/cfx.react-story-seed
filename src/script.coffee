# require 'todomvc-app-css/index.css'
require './style.styl'

{ render } = require 'react-dom'
TodoApp = require './App/index.coffee'

{
  Styl
  cfxify
} = require 'cfx.rw'

{
  Presets
  LookRoot
} = Styl

config = Presets['react-dom']

render (
  LookRoot { config }
  ,
    TodoApp {}
), document.getElementById 'app'
