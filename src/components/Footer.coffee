{
  PropTypes
  Component
} = RW = require 'react'
classnames = require 'classnames'
{
  SHOW_ALL
  SHOW_COMPLETED
  SHOW_ACTIVE
} = require '../constants/TodoFilters'

FILTER_TITLES = {}
FILTER_TITLES[SHOW_ALL] = 'All'
FILTER_TITLES[SHOW_ACTIVE] = 'Active'
FILTER_TITLES[SHOW_COMPLETED] = 'Completed'

class Footer extends Component

  renderTodoCount: ->

    { activeCount } = @props
    itemWord = if activeCount is 1 then 'item' else 'items'

    RW.createElement 'span'
    , className: 'todo-count'
    ,
      RW.createElement 'span'
      , className: 'todo-count'
      ,
        RW.createElement 'strong'
        , {}
        , activeCount or 'No'
      , "#{itemWord} left"

  renderFilterLink: (filter) ->
    title = FILTER_TITLES[filter]
    {
      filter: selectedFilter
      onShow
    } = @props

    RW.createElement 'li'
    , key: filter
    ,
      RW.createElement 'a'
      ,
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

      RW.createElement 'button'
      ,
        className: 'clear-completed'
        onClick: onClearCompleted
      , 'Clear completed'

  render: ->

    RW.createElement 'footer'
    , className: 'footer'
    , @renderTodoCount()
    ,
      RW.createElement.apply @
      ,
        [
          SHOW_ALL
          SHOW_ACTIVE
          SHOW_COMPLETED
        ]
        .reduce(
          (
            (result, filter, index, array) ->
              result.push @renderFilterLink filter
              result
          ).bind @
          [
            'ul'
            className: 'filters'
          ]
        )

    , @renderClearButton()

Footer.propTypes =
  completedCount: PropTypes.number.isRequired
  activeCount: PropTypes.number.isRequired
  filter: PropTypes.string.isRequired
  onClearCompleted: PropTypes.func.isRequired
  onShow: PropTypes.func.isRequired

module.exports = Footer
