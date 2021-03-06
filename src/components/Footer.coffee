{
  PropTypes
  cfx
  Comps
  connect
  Styl
} = require 'cfx.rw'
{ classnames } = Styl
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

Color = require 'color'

styles =

  footer:

    color: '#777'
    padding: '10px 15px'
    height: '20px'
    textAlign: 'center'
    borderTop: '1px solid #e6e6e6'

    before:
      content: '\ '
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

  todoCount:
    float: 'left'
    textAlign: 'left'

  todoCount_Strong:
    fontWeight: 300

  filters:
    margin: '0px'
    padding: 0
    listStyle: 'none'
    position: 'absolute'
    right: 0
    left: 0

  filter: (isSeleted) ->
    base =
      cursor: 'pointer'
      color: 'inherit'
      margin: '3px'
      padding: '3px 7px'
      textDecoration: 'none'
      border: '1px solid transparent'
      borderRadius: '3px'

    if isSeleted
      base = Object.assign {}, base
      ,
        border: '1px solid rgba(175, 47, 47, 0.2)'

    Object.assign {}, base
    ,
      hover:
        border: '1px solid rgba(175, 47, 47, 0.1)'

Footer = cfx

  renderTodoCount: (props, state) ->

    { activeCount } = props

    itemWord =
      if activeCount is 1
      then 'item'
      else 'items'

    span
      className: 'todo-count'
      style: styles.todoCount
    ,
      strong style: styles.todoCount_Strong
      , activeCount or 'No'
    , " #{itemWord} left"

  renderFilterLink: (filter) ->

    title = FILTER_TITLES[filter]
    {
      filter: selectedFilter
      onShow
    } = @props
    isSeleted = filter is selectedFilter

    li
      key: filter
      style: display: 'inline'
    ,
      a
        key: filter
        className: classnames(
          selected: isSeleted
        )
        style: Styl styles.filter isSeleted
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

    footer
      className: 'footer'
      style: Styl styles.footer
    , @renderTodoCount()
    ,
      ul
        className: 'filters'
        style: styles.filters
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
