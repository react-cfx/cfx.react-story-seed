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

    # '@media (max-width: 430px)':
    #   height: '50px'

  todoCounter:
    float: 'left'
    textAlign: 'left'

  todoCounter_strong:
    fontWeight: 300

  filters:
    margin: 0
    padding: 0
    listStyle: 'none'
    position: 'absolute'
    right: 0
    left: 0

    # '@media (max-width: 430px)':
    #   bottom: '10px'

  filter:
    display: 'inline'

  filter_link:
    color: 'inherit'
    margin: '3px'
    padding: '3px 7px'
    textDecoration: 'none'
    border: '1px solid transparent'
    borderRadius: '3px'
    ':hover':
      borderColor: 'rgba(175, 47, 47, 0.1)'

  filter_selected:
    borderColor: 'rgba(175, 47, 47, 0.1)'

  clearCompleted:
    float: 'right'
    position: 'relative'
    lineHeight: '20px'
    textDecoration: 'none'
    cursor: 'pointer'

    ':hover':
      textDecoration: 'underline'

Footer = cfx

  renderTodoCount: (props, state) ->

    { activeCount } = props

    itemWord =
      if activeCount is 1
      then 'item'
      else 'items'

    span className: styles.todoCounter
    ,
      strong className: styles.todoCounter_strong
      , activeCount or 'No'
    , " #{itemWord} left"

  renderFilterLink: (filter) ->

    title = FILTER_TITLES[filter]
    {
      filter: selectedFilter
      onShow
    } = @props

    li
      key: filter
      className: styles.filter
    ,
      a
        className: c(
          do -> styles.filter_selected if filter is selectedFilter
          styles.filter_link
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
        className: styles.clearCompleted
        onClick: -> clearCompleted()
      , 'Clear completed'

  render: ->

    footer className: c(
      'footer'
      styles.footer
    )
    , @renderTodoCount()
    ,
      ul className: styles.filters
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
