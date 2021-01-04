class Node
  attr_accessor :data, :left, :right

  def initialize(data = nil)
    @data = data
    @left = nil
    @right = nil
  end
end

class Tree
  attr_accessor :root

  def initialize(arr=[])
    @root = build_tree(arr.sort, 0, arr.length)
  end

  def build_tree(data=[], start_pointer, end_pointer)
    # Base case.
    return nil if end_pointer < start_pointer

    mid = (start_pointer + end_pointer) / 2
    node = Node.new(data[mid])

    node.left = build_tree(data, start_pointer, mid - 1)
    node.right = build_tree(data, mid+1, end_pointer)

    node
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def insert(value, node = root)
    if node.data.nil?
      new_node = Node.new(value)
      return new_node
    end
    p value
    p node.data


    if value < node.data
      node.left.nil? ? node.left = Node.new(value) : insert(value, node.left)
    else
      node.right.nil? ? node.right = Node.new(value) : insert(value, node.right)
    end
  end

  def delete(value)

  end
end

test_tree = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])

puts test_tree.pretty_print

test_tree.insert(42)
test_tree.insert(9999)
test_tree.insert(6767)
test_tree.insert(19)


puts test_tree.pretty_print