require 'todomvc-app-css/index.css'

{ render } = require 'react-dom'
TodoApp = require './App/index.coffee'

render (
  TodoApp {}
), document.getElementById 'app'
