{
  PropTypes
  classnames
  cfx
  Comps
  connect
} = require 'cfx.rw'
{
  span
  footer
  ul
  li
  a
  strong
  button
} = Comps
constants = require '../constants/Visibility.coffee'
{
  SHOW_TODO_ALL
  SHOW_TODO_ACTIVE
  SHOW_TODO_COMPLETED
} = constants.types

FILTER_TITLES = {}
FILTER_TITLES[SHOW_TODO_ALL] = 'All'
FILTER_TITLES[SHOW_TODO_ACTIVE] = 'Active'
FILTER_TITLES[SHOW_TODO_COMPLETED] = 'Completed'

{ removeTodoState } = require '../actions/index.coffee'

Footer = cfx

  renderTodoCount: ->

    { activeCount } = @props
    itemWord =
      if activeCount is 1
      then 'item'
      else 'items'

    span className: 'todo-count'
    ,
      strong {}
      , activeCount or 'No'
    , " #{itemWord} left"

  renderFilterLink: (filter) ->
    title = FILTER_TITLES[filter]
    {
      filter: selectedFilter
      onShow
    } = @props

    li key: filter
    ,
      a
        className: classnames(
          selected: filter is selectedFilter
        )
        style:
          cursor: 'pointer'
        onClick: -> onShow filter
      , title

  renderClearButton: (props, state) ->
    { todos } = state
    { completedCount } = props
    { removeTodoState } = props.actions

    if completedCount > 0

      button
        className: 'clear-completed'
        onClick: ->
          todos.forEach (todo, index, array) ->
            if todo.completed is true
              removeTodoState
                todoId: todo.id

      , 'Clear completed'

  render: ->

    footer className: 'footer'
    , @renderTodoCount()
    ,
      ul className: 'filters'
      ,
        for filter in [
          SHOW_TODO_ALL
          SHOW_TODO_ACTIVE
          SHOW_TODO_COMPLETED
        ]
          @renderFilterLink filter

    , @renderClearButton()

Footer.propTypes =
  completedCount: PropTypes.number.isRequired
  activeCount: PropTypes.number.isRequired
  filter: PropTypes.string.isRequired
  onShow: PropTypes.func.isRequired

module.exports = connect(
  (state) ->
    todos: state.todoApp.Todos
  { removeTodoState }
  Footer
)
