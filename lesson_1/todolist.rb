class Todo
  DONE_MARKER = 'X'
  UNDONE_MARKER = ' '

  attr_accessor :title, :description, :done

  def initialize(title, description='')
    @title = title
    @description = description
    @done = false
  end

  def done!
    self.done = true
  end

  def done?
    done
  end

  def undone!
    self.done = false
  end

  def to_s
    "[#{done? ? DONE_MARKER : UNDONE_MARKER}] #{title}"
  end
end

class TodoList
  attr_accessor :title

  def initialize(title)
    @title = title
    @todos = []
  end

  def add(obj)
    raise TypeError.new "Can only add Todo objects" if !obj.is_a?(Todo)
    @todos.push(obj)
  end

  alias_method :<<, :add

  def size
    @todos.size
  end

  def first
    @todos.first
  end

  def last
    @todos.last
  end

  def to_a
    @todos.clone
  end

  def item_at(idx)
    @todos.fetch(idx)
  end

  def done?
    @todos.all? { |obj| obj.done? }
  end

  def mark_done_at(idx)
    item_at(idx).done!
  end

  def mark_undone_at(idx)
    item_at(idx).undone!
  end

  def done!
    each { |item| item.done! }
  end

  def mark_all_undone
    each { |obj| obj.undone! }
  end

  alias_method :mark_all_done, :done!

  def shift
    @todos.delete_at(0)
  end

  def pop
    @todos.pop
  end

  def remove_at(idx)
    item_at(idx)
    @todos.delete_at(idx)
  end

  def to_s
    "*****#{title}*****\n"
    (@todos.map { |obj| obj.to_s }).join("\n")
  end

  def each
    @todos.each { |obj| yield(obj) }
    self
  end

  def select
    new_list = TodoList.new(title)
    new_to_dos = @todos.select { |obj| yield(obj) }
    new_to_dos.each { |to_do_obj| new_list.add(to_do_obj) }
    new_list
  end

  def find_by_title(string)
    each { |obj| return obj if obj.title.downcase == string.downcase }
    nil
  end

  def all_done
    select { |obj| obj.done? }
  end

  def all_not_done
    select { |obj| !obj.done? }
  end

  def mark_done(string)
    each { |obj| obj.done! if obj.title.downcase == string.downcase }
  end
end

todo1 = Todo.new("Buy milk")
todo2 = Todo.new("Clean room")
todo3 = Todo.new("Go to gym")

list = TodoList.new("Today's Todos")
list.add(todo1)
list.add(todo2)
list.add(todo3)

puts list

list.each do |todo|
  puts todo
end

todo1 = Todo.new("Buy milk")
todo2 = Todo.new("Clean room")
todo3 = Todo.new("Go to gym")

list = TodoList.new("Today's Todos")
list.add(todo1)
list.add(todo2)
list.add(todo3)

todo1.done!

results = list.select { |todo| todo.done? }    # you need to implement this method

puts results.inspect

list.find_by_title('hi there')

list.all_done
list.all_not_done
list.mark_done('clean room')
list.mark_all_undone