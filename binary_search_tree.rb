class Node
  include Comparable
  attr_accessor :data, :left, :right

  def initialize(data = il, left = nil, right = nil)
    @data = data
    @left = left
    @right = right
  end

  def <=>(other)
    @data <=> other.data
  end
end

class Tree
  attr_accessor :root

  def initialize(arr=[])
    @root = build_tree(arr.sort, 0, arr.length)
  end

  def build_tree(data=[], start_pointer, end_pointer)
    return nil if end_pointer < start_pointer

    mid = (start_pointer + end_pointer) / 2
    node = Node.new(data[mid])

    node.left = build_tree(data, start_pointer, mid - 1)
    node.right = build_tree(data, mid+1, end_pointer)

    node
  end

  def insert(value)

  end

  def delete(value)

  end
end

test_tree = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])

p test_tree