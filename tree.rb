require_relative 'node'

class Tree
  attr_accessor :root

  def initialize(arr=[])
    @root = build_tree(arr)
  end

  def build_tree(data=[], start_pointer, end_pointer)
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