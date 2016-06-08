require 'todomvc-app-css/index.css'

{ render } = require 'react-dom'
TodoApp = require './App/TodoApp.coffee'

render (
  TodoApp {}
), document.getElementById 'app'
