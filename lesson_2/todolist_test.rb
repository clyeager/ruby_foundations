require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require "minitest/reporters"
Minitest::Reporters.use!

require_relative 'todolist'

class TodoListTest < MiniTest::Test

  def setup
    @todo1 = Todo.new("Buy milk")
    @todo2 = Todo.new("Clean room")
    @todo3 = Todo.new("Go to gym")
    @todos = [@todo1, @todo2, @todo3]

    @list = TodoList.new("Today's Todos")
    @list.add(@todo1)
    @list.add(@todo2)
    @list.add(@todo3)
  end

  def test_to_a
    assert_equal(@todos, @list.to_a)
  end

  def test_size
    assert_equal(@todos.size, @list.size)
  end

  def test_first
    assert_equal(@todos.first, @list.first)
  end

  def test_last
    assert_equal(@todos.last, @list.last)
  end

  def test_shift
    todo = @list.shift
    assert_equal(@todo1, todo)
    assert_equal([@todo2, @todo3], @list.to_a)
  end

  def test_pop
    todo = @list.pop
    assert_equal(@todo3, todo)
    assert_equal([@todo1, @todo2], @list.to_a)
  end

  def test_done?
    done = @todos.all? { |todo| todo.done? }
    assert_equal(done, @list.done?)
  end

  def test_type_error
    begin
      @list.add('hi')
    rescue => e
    end

    assert_instance_of(TypeError, e)
  end

  def test_shovel
    todo4 = Todo.new('sweep floor')
    @list << todo4
    assert_equal([@todo1, @todo2, @todo3, todo4], @list.to_a)
  end

  def test_add_alias
    todo4 = Todo.new('sweep floor')
    @list.add(todo4)
    assert_equal([@todo1, @todo2, @todo3, todo4], @list.to_a)
  end

  def test_item_at
    idx0 = @list.item_at(0)
    assert_equal(@todos[0], idx0)
    assert_raises(IndexError) { @list.item_at(10) }
  end

  def test_mark_done_at
    assert_equal(@todo1.done!, @list.mark_done_at(0))
    assert_raises(IndexError) { @list.mark_done_at(10) }
  end

  def test_mark_undone_at
    @todo1.done!

    assert_equal(@todo1.undone!, @list.mark_undone_at(0))
    assert_raises(IndexError) { @list.mark_undone_at(10) }
  end

  def test_done!
    @list.done!
    assert_equal(true, @todo1.done?)
    assert_equal(true, @todo2.done?)
  end

  def test_mark_all_undone
    @todo1.done!
    @list.mark_all_undone
    assert_equal(false, @todo1.done?)
    assert_equal(false, @todo2.done?)
    assert_equal(false, @todo3.done?)
  end

  def test_mark_all_done
    @list.mark_all_done
    assert_equal(true, @todo1.done?)
    assert_equal(true, @todo2.done?)
    assert_equal(true, @todo3.done?)
  end

  def test_remove_at
    todo = @list.remove_at(0)
    assert_equal(@todo1, todo)
    assert_equal([@todo2, @todo3], @list.to_a)
    assert_raises(IndexError) { @list.remove_at(100) }
  end

  def test_to_s
    output = <<~OUTPUT.chomp
    ---- Today's Todos ----
    [ ] Buy milk
    [ ] Clean room
    [ ] Go to gym
    OUTPUT

    assert_equal(output, @list.to_s)
  end

  def test_done_to_s
    @todo1.done!
    output = output = <<~OUTPUT.chomp
    ---- Today's Todos ----
    [X] Buy milk
    [ ] Clean room
    [ ] Go to gym
    OUTPUT
    assert_equal(output, @list.to_s)
  end

  def test_done_to_s
    @list.done!
    output = output = <<~OUTPUT.chomp
    ---- Today's Todos ----
    [X] Buy milk
    [X] Clean room
    [X] Go to gym
    OUTPUT
    assert_equal(output, @list.to_s)
  end

  def test_each
    all_todos = []
    @list.each { |todo| all_todos << todo }
    assert_equal([@todo1, @todo2, @todo3], all_todos)
  end

  def test_each_return_value
    return_value = @list.each { |todo| }
    assert_equal(@list, return_value)
  end

  def test_select
    @todo1.done!

    new_list = @list.select { |todo| todo.done? }
    assert_instance_of(TodoList, new_list)
    assert_equal([@todo1], new_list.to_a)
  end

  def test_find_by_title
    return_value = @list.find_by_title('hi there')
    assert_equal(nil, return_value)

    obj = @list.find_by_title('Buy milk')
    assert_equal(@todo1, obj)
  end

  def test_all_done
    @todo1.done!
    @todo3.done!
    new_list = @list.all_done

    assert_instance_of(TodoList, new_list)
    assert_equal([@todo1, @todo3], new_list.to_a)
  end

  def test_all_not_done
    @todo1.done!
    @todo3.done!
    new_list = @list.all_not_done

    assert_instance_of(TodoList, new_list)
    assert_equal([@todo2], new_list.to_a)
  end

  def test_mark_done
    return_value = @list.mark_done('Buy milk')
    assert_instance_of(TodoList, return_value)
    assert(@todo1.done?)
  end
end
