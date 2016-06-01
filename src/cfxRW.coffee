React = require 'react'
{
  createElement
  createClass
} = React
{ render } = require 'react-dom'

Radium = require 'radium'

cfxify = (e) ->
  (args...) -> createElement.apply @
  , [ e ].concat args
cfx = ->
  cfxify Radium createClass.apply @
  , arguments

# Style = cfxify Radium.Style

Comps = {}
for tag in [
  'div'
  'h1'
]
  Comps[tag] = cfxify tag

module.exports = {
  RW: React
  render
  cfx
  cfxify
  Comps
}
