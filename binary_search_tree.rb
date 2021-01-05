class Node
  include Comparable
  attr_accessor :data, :left, :right

  def initialize(data = nil, left = nil, right = nil)
    @data = data
    @left = left
    @right = right
  end
  def <=>(other)

  end
end

class Tree
  attr_accessor :root

  def initialize(arr=[])
    @root = build_tree(arr.sort, 0, arr.length - 1)
  end

  def build_tree(arr=[], beginning, ending)
    # Base case.
    return nil if ending < beginning

    # Calculate midpoint.
    mid = (beginning + ending) / 2

    # Build left and right trees.
    left = build_tree(arr, beginning, mid - 1)
    right = build_tree(arr, mid + 1, ending)

    # Connect left and right trees to root node.
    @root = Node.new(arr[mid], left, right)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def insert(value, node = @root)
    return Node.new(value) if node.nil?
    if value < node.data
      node.left.nil? ? node.left = Node.new(value) : insert(value, node.left)
    else
      node.right.nil? ? node.right = Node.new(value) : insert(value, node.right)
    end
  end

  def delete(value, node = root)
    return node if node.nil?


  end
end

test_tree = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])

puts test_tree.pretty_print

test_tree.insert(42)
test_tree.insert(9999)
test_tree.insert(6767)
test_tree.insert(19)
test_tree.insert(6)
test_tree.insert(8000)
test_tree.insert(1)
test_tree.insert(2)
test_tree.insert(3)


puts test_tree.pretty_print