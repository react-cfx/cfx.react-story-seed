{
  cfx
  Provider
} = require 'cfx.rw'

store = require './store.coffee'
TodoApp = require './TodoApp.coffee'

module.exports = cfx ->

  Provider { store }
  ,
    TodoApp {}
