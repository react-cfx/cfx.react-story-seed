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

constants = require '../constants/index.coffee'
{
  SHOW_TODO_ALL
  SHOW_TODO_ACTIVE
  SHOW_TODO_COMPLETED
} = constants.types

console.log constants

FILTER_TITLES =
  SHOW_TODO_ALL: 'All'
  SHOW_TODO_ACTIVE: 'Active'
  SHOW_TODO_COMPLETED: 'Completed'

Footer = cfx

  renderTodoCount: (props, state) ->

    { activeCount } = props

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

    {
      completedCount
      clearCompleted
    } = props

    if completedCount > 0

      button
        className: 'clear-completed'
        onClick: -> clearCompleted()
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
  activeCount: PropTypes.number.isRequired
  completedCount: PropTypes.number.isRequired
  filter: PropTypes.string.isRequired
  onShow: PropTypes.func.isRequired
  clearCompleted: PropTypes.func.isRequired

module.exports = Footer
