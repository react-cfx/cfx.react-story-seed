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
  input
  section
  ul
} = Comps

constants = require '../constants/index.coffee'
{
  SHOW_TODO_ALL
  SHOW_TODO_ACTIVE
  SHOW_TODO_COMPLETED
} = constants.types

TODO_FILTERS =
  SHOW_TODO_ALL: -> true
  SHOW_TODO_ACTIVE: (todo) -> not todo.completed
  SHOW_TODO_COMPLETED: (todo) -> todo.completed

styles = Styl

  main:
    position: 'relative'
    zIndex: 2
    borderTop: '1px solid #e6e6e6'

  toggleAll:
    position: 'absolute'
    top: '-55px'
    left: '-12px'
    width: '60px'
    height: '34px'
    textAlign: 'center'
    border: 'none'

    ':before':
      # content: '❯'
      fontSize: '22px'
      color: '#e6e6e6'

    ':checked':
      ':before':
        color: '#737373'

  todoList:
    margin: 0
    padding: 0
    listStyle: 'none'

MainSection = (TodoItem, Footer) -> cfx

  _getCount: (newProps, oldProps, state) ->

    getCount = (todos, countCompleted) ->
      activeCount = (
        todos.filter TODO_FILTERS[SHOW_TODO_ACTIVE]
      ).length
      if countCompleted
        completedCount = todos.length - activeCount
      else
        completedCount = null
      {
        activeCount
        completedCount
      }

    unless @state
      {
        activeCount
        completedCount
      } = getCount state.todos, true
    else
      { todos } = newProps.state
      { activeCount } = getCount todos, false
      unless activeCount is @state.activeCount
        completedCount = todos.length - activeCount
      else
        {
          activeCount
          completedCount
        } = @state
    {
      activeCount
      completedCount
    }

  constructor: (props, state) ->
    {
      activeCount
      completedCount
    } = @_getCount null
    @state = {
      activeCount
      completedCount
      filter: SHOW_TODO_ALL
    }

  componentWillReceiveProps: (nextProps) ->
    {
      activeCount
      completedCount
    } = @_getCount nextProps
    @setState Object.assign {}
    , @state
    , {
      activeCount
      completedCount
    }

  handleClearCompleted: (props, state) ->
    { todos } = state
    { removeTodoState } = props.actions
    todos.forEach (todo, index, array) ->
      if todo.completed
        removeTodoState
          todoId: todo.id

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

  renderToggleAll: (props, state) ->
    { todos } = state
    # { completedCount } = @state

    if todos.length > 0

      input
        className: c(
          'toggle-all'
          styles.toggleAll
        )
        type: 'checkbox'
        # checked: completedCount is todos.length
        onChange: @toggleAll

  renderFooter: (props, state) ->
    { todos } = state
    {
      activeCount
      completedCount
      filter
    } = @state

    if todos.length
      Footer {
        activeCount
        completedCount
        filter
        onShow: @handleShow.bind @
        clearCompleted: @handleClearCompleted.bind @
      }

  render: (props, state) ->
    { todos } = state
    { filter } = @state

    filteredTodos = todos.filter TODO_FILTERS[filter]

    section className: styles.main
    ,
      @renderToggleAll()
    ,
      ul className: c(
        'todo-list'
        styles.todoList
      )
      ,
        for todo in filteredTodos
          TodoItem
            key: todo.id
            todo: todo
    , @renderFooter()

module.exports = MainSection
