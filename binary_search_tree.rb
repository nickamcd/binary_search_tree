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
    return node if value == node.data || node.nil?

    if value < node.data
      find(value, node.left)
    else
      find(value, node.right)
    end
  end

  def level_order
    queue = []
    data_arr = []

    # Begin traversal at root.
    queue << @root
    
    until queue.empty?
      # Remove first node of queue.
      node = queue.shift

      # Store data.
      data_arr << node.data

      # Queue any children.
      unless node.left.nil?
        queue << node.left
      end
      unless node.right.nil?
        queue << node.right
      end
    end
    data_arr
  end

  def inorder(arr = [], node = @root)
    # Base case.
    return arr if node.nil?

    inorder(arr, node.left)
    arr.push(node.data)
    inorder(arr, node.right)
  end

  def preorder(arr = [], node = @root)
    # Base case.
    return arr if node.nil?

    arr.push(node.data)
    preorder(arr, node.left)
    preorder(arr, node.right)
  end

  def postorder(arr = [], node = @root)
    # Base case.
    return arr if node.nil?

    postorder(arr, node.left)
    postorder(arr, node.right)
    arr.push(node.data)
  end

  def height(node = @root)
    # Base case.
    return -1 if node.nil?

    return [height(node.left), height(node.right)].max + 1
  end

  def depth(node = @root)
    # Base case. Node is nil.
    return -1 if node.nil?
    # Base case. Already at root.
    return 0 if node == @root

    height(root) - height(node)
  end

  def balanced?(node = @root)
    # Base case. Empty tree.
    return true if node.nil?

    left_height = height(node.left)
    right_height = height(node.right)

    return true if (left_height - right_height).abs <= 1 && balanced?(node.left) && balanced?(node.right)
    return false
  end

  def rebalance
    arr = self.level_order
    build_tree(arr.sort, 0, arr.length - 1)
  end
end

test_tree = Tree.new(Array.new(15){ rand(1..100) })

test_tree.pretty_print
puts "Is the tree balanced? #{test_tree.balanced?}"

puts "Level-Order: #{test_tree.level_order}"
puts "Preorder: #{test_tree.preorder}"
puts "Postorder: #{test_tree.postorder}"
puts "Inorder: #{test_tree.inorder}"

test_tree.insert(101)
test_tree.insert(500)
test_tree.insert(999)

test_tree.pretty_print
puts "Is the tree balanced? #{test_tree.balanced?}"

puts "Rebalancing..."
test_tree.rebalance
test_tree.pretty_print
puts "Is the tree balanced? #{test_tree.balanced?}"

puts "Level-Order: #{test_tree.level_order}"
puts "Preorder: #{test_tree.preorder}"
puts "Postorder: #{test_tree.postorder}"
puts "Inorder: #{test_tree.inorder}"