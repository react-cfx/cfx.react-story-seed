{
  PropTypes
  classnames
  cfx
  Comps
  connect
  c
  Styl
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

FILTER_TITLES =
  SHOW_TODO_ALL: 'All'
  SHOW_TODO_ACTIVE: 'Active'
  SHOW_TODO_COMPLETED: 'Completed'

styles = Styl

  footer:
    color: '#777'
    padding: '10px 15px'
    height: '20px'
    textAlign: 'center'
    borderTop: '1px solid #e6e6e6'

    ':before':
      # content: ''
      position: 'absolute'
      right: 0
      bottom: 0
      left: 0
      height: '50px'
      overflow: 'hidden'

      boxShadow: """
        0 1px 1px rgba(0, 0, 0, 0.2),
        0 8px 0 -3px #f6f6f6,
  	    0 9px 1px -3px rgba(0, 0, 0, 0.2),
  	    0 16px 0 -6px #f6f6f6,
  	    0 17px 2px -6px rgba(0, 0, 0, 0.2)
      """

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

    footer className: c(
      'footer'
      styles.footer
    )
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
