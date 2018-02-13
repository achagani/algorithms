class Node
  attr_accessor :left, :right
  @data= nil
  @left = nil
  @right = nil

  def initialize(d)
    @data = d
  end
end


def find_max_sum(node)
    if node.nil?
        return 0
    end

    if node.left.data > 0
    end
end


root = Node.new(10)
root.left = Node.new(2)
root.right   = Node.new(10);
root.left.left  = Node.new(20);
root.left.right = Node.new(1);
root.right.right = Node.new(-25);
root.right.right.left   = Node.new(3);
root.right.right.right  = Node.new(4);
print "Max path sum is  #{find_max_sum(root)}"
