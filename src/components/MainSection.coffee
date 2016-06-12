{
  PropTypes
  classnames
  cfx
  Comps
  connect
} = require 'cfx.rw'
{
  input
  section
  ul
} = Comps

TodoItem = require './TodoItem.coffee'
Footer = require './Footer.coffee'
constants = require '../constants/Visibility.coffee'

{
  SHOW_TODO_ALL
  SHOW_TODO_ACTIVE
  SHOW_TODO_COMPLETED
} = constants.types

{ modifyTodoState } = require '../actions/index.coffee'

TODO_FILTERS = {}
TODO_FILTERS[SHOW_TODO_ALL] = -> true
TODO_FILTERS[SHOW_TODO_ACTIVE] = (todo) -> not todo.completed
TODO_FILTERS[SHOW_TODO_COMPLETED] = (todo) -> todo.completed

MainSection = cfx

  constructor: (props, state) ->
    @state = filter: SHOW_TODO_ALL

  handleClearCompleted: ->
    @props.actions.clearCompleted()

  handleShow: (filter) ->
    @setState {filter}

  toggleAll: (e, props, state) ->
    { todos } = state
    { modifyTodoState } = props.actions
    allSelected = true

    todos.forEach (todo, index, array) ->
      unless todo.completed
        allSelected = false

    unless allSelected
      todos.forEach (todo, index, array) ->
        unless todo.completed
          modifyTodoState
            todo:
              id: todo.id
              completed: true
    else
      todos.forEach (todo, index, array) ->
        if todo.completed
          modifyTodoState
            todo:
              id: todo.id
              completed: false

  renderToggleAll: (completedCount, props, state) ->
    { todos } = state

    if todos.length > 0

      input
        className: 'toggle-all'
        type: 'checkbox'
        # checked: completedCount is todos.length
        onChange: @toggleAll

  renderFooter: (completedCount, props, state) ->
    { todos } = state
    { filter } = @state
    activeCount = todos.length - completedCount

    if todos.length
      Footer {
        completedCount
        activeCount
        filter
        onShow: @handleShow.bind @
      }

  render: (props, state) ->
    { todos } = state
    { actions } = @props
    { filter } = @state

    filteredTodos = todos.filter TODO_FILTERS[filter]
    completedCount = todos.reduce (count, todo) ->
      if todo.completed then count + 1 else count
    , 0

    section className: 'main'
    ,
      @renderToggleAll completedCount
    ,
      ul className: 'todo-list'
      ,
        for todo in filteredTodos
          TodoItem Object.assign {}
          ,
            key: todo.id
            todo: todo
          , actions
    , @renderFooter completedCount

module.exports = connect(
  (state) ->
    todos: state.todoApp.Todos
  { modifyTodoState }
  MainSection
)
