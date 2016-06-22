{ configure } = require '@kadira/storybook'
require '../src/style.styl'
# require 'todomvc-app-css/index.css'

loadStories = -> require '../storybook/stories/index.coffee'

module.exports = configure loadStories, module
