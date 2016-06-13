Components = require '../../src/components/index.coffee'

TodoItem = Components.TodoItem(
  Components.TodoTextInput
)

Header = Components.Header(
  Components.TodoTextInput
)

{ Footer } = Components

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

MainSection = (props) ->
  if props._Options
    Options = props._Options
    delete props._Options

  Components.MainSection(
    tagWapper TodoItem
    , Options.TodoItem
    tagWapper Footer
    , Options.Footer
  ) props

module.exports = {
  TodoItem
  Header
  Footer
  MainSection
}
