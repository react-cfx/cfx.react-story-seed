{ createStore } = require 'cfx.redux'

reducersPath = '../reducers/index.coffee'
reducers = require reducersPath

createLogger = require 'redux-logger'

store = createStore
  todoApp: reducers
, [
  createLogger()
]

# if module.hot
#   # Enable Webpack hot module replacement for reducers
#   module.hot.accept reducersPath, ->
#     nextReducer = require reducers
#     store.replaceReducer reducersPath nextReducer

module.exports = store
