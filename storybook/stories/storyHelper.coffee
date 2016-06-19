{ Styl } = require 'cfx.rw'

{
  Presets
  LookRoot
} = Styl

config = Presets['react-dom']

lookRootWapper = (getComponent) -> ->
  LookRoot { config }
  ,
    getComponent()

tagWapper = (tagFunc, option) ->
  (props) ->
    args = []
    args.push props if props
    args.push option if option

    if args.length is 2
      args = [
        Object.assign {}
        , props
        , option
      ]

    tagFunc.apply @, args

module.exports =
  wapper:
    lookRoot: lookRootWapper
    tag: tagWapper
