# Trees & Graphs

require "benchmark"


class Graph

  def initialize
    @graph = Hash.new
  end

  def add(v1, v2)
    if @graph[v1].nil?
      @graph[v1] = [v2]
    else
      @graph[v1].push v2
    end
  end

  def _dfs_helper(v, visited)
    print v, ','

    if !@graph[v]
      return
    end

    for vertex in @graph[v]
      if !visited.include?(vertex)
        visited.push(vertex)
        self._dfs_helper(vertex, visited)
      end
    end

  end

  def dfs(v)
    _dfs_helper(v, [])
  end

  def bfs(v)
    visited = Array.new
    q = Array.new(@graph[v])
    print v, ','
    visited.push(v)
    while !q.empty?
      vertex = q.shift
      if !visited.include?(vertex)
        print vertex, ','
        visited.push(vertex)
        if @graph[vertex]
          q = (q + @graph[vertex]).uniq
        end
      end
    end
  end

end

# g = Graph.new

# g.add(0, 1)
# g.add(0, 2)
# g.add(1, 2)
# g.add(2, 0)
# g.add(2, 3)
# g.add(3, 3)

# g.bfs(2)

g = Graph.new
g.add 1, 2
g.add 1, 3
g.add 2, 4
g.add 3, 4
g.add 4, 5
g.add 4, 6


puts "DFS"
g.dfs(1)

puts "\nBFS"
g.bfs(1)
puts ""
