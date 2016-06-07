{
  PropTypes
  classnames
  cfx
  Comps
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
{
  SHOW_ALL
  SHOW_COMPLETED
  SHOW_ACTIVE
} = require '../constants/TodoFilters'

FILTER_TITLES = {}
FILTER_TITLES[SHOW_ALL] = 'All'
FILTER_TITLES[SHOW_ACTIVE] = 'Active'
FILTER_TITLES[SHOW_COMPLETED] = 'Completed'

Footer = cfx

  renderTodoCount: ->

    { activeCount } = @props
    itemWord =
      if activeCount is 1
      then 'item'
      else 'items'

    span className: 'todo-count'
    ,
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

  renderClearButton: ->
    {
      completedCount
      onClearCompleted
    } = @props
    if completedCount > 0

      button
        className: 'clear-completed'
        onClick: onClearCompleted
      , 'Clear completed'

  render: ->

    footer className: 'footer'
    , @renderTodoCount()
    ,
      ul className: 'filters'
      ,
        for filter in [
          SHOW_ALL
          SHOW_ACTIVE
          SHOW_COMPLETED
        ]
          @renderFilterLink filter

    , @renderClearButton()

Footer.propTypes =
  completedCount: PropTypes.number.isRequired
  activeCount: PropTypes.number.isRequired
  filter: PropTypes.string.isRequired
  onClearCompleted: PropTypes.func.isRequired
  onShow: PropTypes.func.isRequired

module.exports = Footer
