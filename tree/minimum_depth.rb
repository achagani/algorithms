class Node
  attr_accessor :left, :right
  @data= nil
  @left = nil
  @right = nil

  def initialize(d)
    @data = d
  end
end


def min_depth(node)
  if node.nil?
    return 0
  end
  if node.left.nil? && node.right.nil?
    return 1
  end

  if node.right.nil?
    return min_depth(node.left) + 1
  elsif node.left.nil?
    return min_depth(node.right) + 1
  end

  return [min_depth(node.left), min_depth(node.right)].min + 1
end

# Driver Program
root = Node.new(1)
root.left = Node.new(2)
root.right = Node.new(3)
root.left.left = Node.new(4)
root.left.right = Node.new(5)
print min_depth(root)
