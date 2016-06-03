{
  PropTypes
  Component
} = RW = require 'react'
TodoItem = require './TodoItem.coffee'
Footer = require './Footer.coffee'
{
  SHOW_ALL
  SHOW_COMPLETED
  SHOW_ACTIVE
} = require '../constants/TodoFilters'

TODO_FILTERS = {}
TODO_FILTERS[SHOW_ALL] = -> true
TODO_FILTERS[SHOW_ACTIVE] = (todo) -> not todo.completed
TODO_FILTERS[SHOW_COMPLETED] = (todo) -> todo.completed

class MainSection extends Component

  constructor: (props, context) ->
    super props, context
    @state = filter: SHOW_ALL

  handleClearCompleted: ->
    @props.actions.clearCompleted()

  handleShow: (filter) ->
    @setState {filter}

  renderToggleAll: (completedCount) ->
    {
      todos
      actions
    } = @props

    if todos.length > 0

      RW.createElement 'input'
      ,
        className: 'toggle-all'
        type: 'checkbox'
        checked: completedCount is todos.length
        onChange: actions.completeAll

  renderFooter: (completedCount) ->
    { todos } = @props
    { filter } = @state
    activeCount = todos.length - completedCount

    if todos.length
      RW.createElement Footer
      , {
        completedCount
        activeCount
        filter
        onClearCompleted: @handleClearCompleted.bind @
        onShow: @handleShow.bind @
      }

  render: ->
    {
      todos
      actions
    } = @props
    { filter } = @state

    filteredTodos = todos.filter TODO_FILTERS[filter]
    completedCount = todos.reduce (count, todo) ->
      if todo.completed then count + 1 else count
    , 0

    console.log {
      filteredTodos
      completedCount
    }

    RW.createElement 'section'
    , className: 'main'
    ,
      @renderToggleAll completedCount
    ,
      RW.createElement.apply @
      ,
        filteredTodos.reduce (result, todo) ->
          result.push (
            RW.createElement TodoItem
            ,
              Object.assign {}
              ,
                key: todo.id
                todo: todo
              , actions
          )
          result
        , [
          'ul'
          className: 'todo-list'
        ]
    , @renderFooter completedCount

MainSection.propTypes =
  todos: PropTypes.array.isRequired
  actions: PropTypes.object.isRequired

module.exports = MainSection
