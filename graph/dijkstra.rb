class Graph
  attr_accessor :graph

  def print_graph
    width = self.graph.flatten.max.to_s.size + 2
    puts self.graph.map {|a|
      a.map { |i|
        i.to_s.rjust(width)
      }.join
    }
  end

  def dijkstra(v)
    spt_set= Array.new

    # Root Case
    q = Array.new
    q.push({:vertex => 0, :cost => 0})
    spt_set.push(0)

    while !q.empty?
      adj_v = q.shift
      v = adj_v[:vertex]
      v_cost = adj_v[:cost]
      spt_set.push(v)
      puts "#{v}: #{v_cost}"


      self.graph.size.times do |i|
        # puts "i: #{i}"
        cost = self.graph[v][i] > 0 ? self.graph[v][i] : nil
        if !cost.nil? && !spt_set.include?(i)
          existing_q = q.select {|x| x[:vertex] == i}.first
          if existing_q && existing_q[:cost] > v_cost + cost
            existing_q[:cost] = v_cost + cost
          elsif !existing_q
            q.push({:vertex => i, :cost => v_cost + cost})
          end
          q.sort_by! {|x| x[:cost]}
        end
      end

    end

  end
end



g = Graph.new
g.graph = [[0, 4, 0, 0, 0, 0, 0, 8, 0],
           [4, 0, 8, 0, 0, 0, 0, 11, 0],
           [0, 8, 0, 7, 0, 4, 0, 0, 2],
           [0, 0, 7, 0, 9, 14, 0, 0, 0],
           [0, 0, 0, 9, 0, 10, 0, 0, 0],
           [0, 0, 4, 14, 10, 0, 2, 0, 0],
           [0, 0, 0, 0, 0, 2, 0, 1, 6],
           [8, 11, 0, 0, 0, 0, 1, 0, 7],
           [0, 0, 2, 0, 0, 0, 6, 7, 0]
           ];

puts "\n\n"
g.print_graph
puts "\n\n"
g.dijkstra(0);
