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
    puts node.data
    # Traverse tree looking for node to delete.
    if value < node.data
      puts node.data
      puts value
      puts "going left"
      node.left = delete(value, node.left)
    elsif value > node.data
      puts node.data
      puts value
      puts "going right"
      node.right = delete(value, node.right)
    else
      puts "deleting #{value}"
      # Node with one/zero children.
      return node.right if node.left.nil?
      return node.left if node.right.nil?

      # Node with two children.
      node.data = minimum_value(node.right).data
      node.right = delete(node.data, node.right)
    end
    node
  end

  def minimum_value(node)
    node.left until node.left.nil?
  end
end

test_tree = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])

puts test_tree.pretty_print

test_tree.insert(42)
test_tree.insert(15)
test_tree.insert(3)
test_tree.insert(8000)

puts test_tree.pretty_print

test_tree.delete(67)
test_tree.delete(5)

puts test_tree.pretty_print