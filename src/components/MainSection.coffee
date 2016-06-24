{
  PropTypes
  cfx
  Comps
  connect
  Styl
} = require 'cfx.rw'
{ classnames } = Styl
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

styles =

  toggleAll: (isChecked) ->

    position: 'absolute'
    top: '-55px'
    left: '-12px'
    width: '60px'
    height: '34px'
    textAlign: 'center'
    border: 'none'

    before:
      content: '❯'
      fontSize: '22px'
      color:
        unless isChecked
        then '#e6e6e6'
        else '#737373'
      padding: '10px 27px 10px 27px'

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
      isToggleAll: false
    }

  componentWillReceiveProps: (nextProps) ->
    {
      activeCount
      completedCount
    } = @_getCount nextProps

    @setState {
      activeCount
      completedCount
      isToggleAll:
        if activeCount is 0
        then true
        else false
    }

  handleClearCompleted: (props, state) ->
    { todos } = state
    { removeTodoState } = props.actions
    todos.forEach (todo, index, array) ->
      if todo.completed
        removeTodoState
          todoId: todo.id

  handleShow: (filter) -> @setState {filter}

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

    if todos.length > 0

      input
        className: 'toggle-all'
        style: Styl styles.toggleAll @state.isToggleAll
        type: 'checkbox'
        checked: @state.isToggleAll
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

    section className: 'main'
    ,
      @renderToggleAll()
    ,
      ul className: 'todo-list'
      ,
        for index, todo of filteredTodos
          TodoItem
            key: todo.id
            todo: todo
            atLast: (~~index + 1) is filteredTodos.length
    , @renderFooter()

module.exports = MainSection
