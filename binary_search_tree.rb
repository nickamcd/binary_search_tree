class Node
  attr_accessor :data, :left, :right

  def initialize(data = nil, left = nil, right = nil)
    @data = data
    @left = left
    @right = right
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
    # Base case. Empty tree.
    return Node.new(value) if node.nil?

    # Compare with value at node.
    # < inserts to the left, >= inserts to the right.
    if value < node.data
      # If the left child is nil, create node.
      # Otherwise, call insert on child node.
      node.left.nil? ? node.left = Node.new(value) : insert(value, node.left)
    else
      node.right.nil? ? node.right = Node.new(value) : insert(value, node.right)
    end
  end

  def delete(value, node = @root)
    # Base case. Empty tree.
    return node if node.nil?
    # Traverse tree looking for node to delete.
    if value < node.data
      node.left = delete(value, node.left)
    elsif value > node.data
      node.right = delete(value, node.right)
    else
      # Node with one/zero children.
      return node.right if node.left.nil?
      return node.left if node.right.nil?

      # Node with two children.
      node.data = minimum_value(node.right).data
      node.right = delete(node.data, node.right)
    end
    node
  end

  # Find minimum value of left subtree.
  def minimum_value(node)
    node = node.left until node.left.nil?
    node
  end

  def find(value, node = @root)
    # Base case. Root is the desired valued
    return node if value == node.data

    if value < node.data
      find(value, node.left)
    elsif value > node.data
      find(value, node.right)
    else
      node
    end
  end
end

test_tree = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])

puts test_tree.pretty_print

puts "Inserting 42, 15, 3, then 8000.\n\n"


test_tree.insert(42)
test_tree.insert(15)
test_tree.insert(3)
test_tree.insert(8000)

puts test_tree.pretty_print

puts "Deleting 67, 23, 5, then 3.\n\n"

test_tree.delete(67)
test_tree.delete(23)
test_tree.delete(5)
test_tree.delete(3)

puts test_tree.pretty_print

puts "Testing find on 42, 8, and 15\n\n"

puts test_tree.find(42).data
puts test_tree.find(8).data
puts test_tree.find(15).data