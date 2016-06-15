Components = require '../../src/components/index.coffee'
{ wapper } = require './storyHelper.coffee'

TodoItem = Components.TodoItem(
  Components.TodoTextInput
)

Header = Components.Header(
  Components.TodoTextInput
)

{ Footer } = Components

MainSection = (props) ->
  if props._Options
    Options = props._Options
    delete props._Options

  Components.MainSection(
    wapper.tag TodoItem
    , Options.TodoItem
    wapper.tag Footer
    , Options.Footer
  ) props

module.exports = {
  TodoItem
  Header
  Footer
  MainSection
}
