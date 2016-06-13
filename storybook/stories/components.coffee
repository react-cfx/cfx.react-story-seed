Components = require '../../src/components/index.coffee'

TodoItem = Components.TodoItem(
  Components.TodoTextInput
)

Header = Components.Header(
  Components.TodoTextInput
)

{ Footer } = Components

tagWapper = (props, option, tagFunc) ->
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

MainSection = (Options) ->

  Components.MainSection(
    (props) ->
      tagWapper.apply @, [
        props
        Options.TodoItem
        TodoItem
      ]
    (props) ->
      tagWapper.apply @, [
        props
        Options.Footer
        Footer
      ]
  )

module.exports = {
  TodoItem
  Header
  Footer
  MainSection
}
