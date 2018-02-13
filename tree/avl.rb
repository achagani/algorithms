class Node
  attr_accessor :left, :right, :data
  @data = nil
  @left = nil
  @right = nil

  def initialize(d)
    @data = d
  end
end

class Tree

  def initialize(root)
    @root = root
  end

  def _dfs_pre_order(node)
    if !node.nil?
      print node.data, ", "
      _dfs_pre_order(node.left)
      _dfs_pre_order(node.right)
    end
  end

  def dfs_pre_order()
    self._dfs_pre_order(@root)
    puts ""
  end

  def height(node)
    if node.nil?
      return 0
    end

    if node.left.nil? and node.right.nil?
      return 1
    end

    if node.right.nil?
      return 1 +  height(node.left)
    end

    if node.left.nil?
      return 1 + height(node.right)
    end

    return [height(node.left), height(node.right)].max
  end

  def get_balance(node)
    l = self.height(node.left)
    r = self.height(node.right)
    # puts "l: #{l}"
    # puts "r: #{r}"
    return l - r
  end

  def _rebalance(node, val)
    balance = self.get_balance(node)

    # LEFT LEFT
    if balance > 1 && val < node.data
      puts "LEFT LEFT: #{node.data}"
      puts "Balance: #{balance}"
    end

    # LEFT RIGHT
    if balance > 1 && val > node.data
      puts "LEFT RIGHT: #{node.data}"
      puts "Balance: #{balance}"
    end

    # RIGHT LEFT
    if balance < -1 && node.right.right.nil?
      puts "RIGHT LEFT: #{node.data}"
      puts "Balance: #{balance}"
      self._rotate_right!(node)
      self._rotate_left!(node)
    end

    # RIGHT RIGHT
    if balance < -1 && node.right.left.nil?
      puts "RIGHT RIGHT: #{node.data}"
      puts "Balance: #{balance}"
      puts "Value: #{val}"
    end

  end

  def _rotate_right!(node)
  	puts "before: #{node.data}, #{node.right.data}, #{node.right.left.data}"
    root_right = node.right
    root_right_left = node.right.left
    
    node.right = root_right_left
    node.right.right = root_right
  	puts "after: #{node.data}, #{node.right.data}, #{node.right.right.data}"
  end

  def _rotate_left!(node)
  end

  def _insert(node, val)
    # puts "node: #{node.data}"
    if val < node.data
      if node.left.nil?
        node.left = Node.new(val)
      else
        self._insert(node.left, val)
      end
    end

    if val > node.data
      if node.right.nil?
        node.right = Node.new(val)
      else
        self._insert(node.right, val)
      end
    end
    self._rebalance(node, val)
  end

  def insert(val)
    self._insert(@root, val)
  end
end


tree = Tree.new(Node.new(10))
tree.insert(50)
tree.insert(40)
# tree.insert(40)
# tree.insert(5)
# tree.insert(11)
# tree.insert(16)
# tree.insert(4)
# tree.insert(8)
# tree.insert(3)
# tree.insert(1)
# tree.insert(0.5)

puts tree.dfs_pre_order()

# puts tree.get_balance()
