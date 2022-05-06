class Node
  attr_reader :visited, :distance, :x, :y, :weight
  
  def initialize weight, x, y
    @visited = false
    @distance = 1_000_000_000
    @weight = weight
    @x = x
    @y = y
  end

  def setDistance(distance) 
    @distance = distance
  end
end

def setup
  data = File.open("sample.txt").readlines
    .map { |line| line.chomp.split("").map &:to_i }
  output = data.map { |line| line + Array.new(line.length * 5) }
  output += Array.new(data.length * 4, Array.new(data[0].length * 5))
  data.each.with_index do |line, row|
    line.each.with_index do |num, col|
      5.times.with_index do |i|
        output[row][(data[0].length * i) + col] = (num + i) % 9
      end 
    end
  end
  output
end

def gimme graph, visited
  graph.each do |line|
    line.each do |node|
      print(visited.include?(node) ? "  , " : "#{node.distance}, ") 
    end
    puts
  end
end

graph = setup.map.with_index { |arr, y| arr.map.with_index { |weight, x| Node.new(weight, x, y) } }
current = graph[0][0]
current.setDistance(0)
dest = graph[-1][-1]

def find_nearest graph, visited, dest
  nearest = dest
  graph.each do |line|
    line.each do |node|
      unless visited.include? node
        nearest = (node.distance < nearest.distance ? node : nearest)
      end
    end
  end
  nearest
end

def dijkstra(current, dest, graph)
  visited = []
  unvisited = graph.flatten
  while true
    unless current.y - 1 < 0 || visited.include?(graph[current.y - 1][current.x])
      graph[current.y - 1][current.x].setDistance([graph[current.y - 1][current.x].distance, current.distance + graph[current.y - 1][current.x].weight].min)
    end
    
    unless current.x - 1 < 0 || visited.include?(graph[current.y][current.x - 1])
      graph[current.y][current.x - 1].setDistance([graph[current.y][current.x - 1].distance, current.distance + graph[current.y][current.x - 1].weight].min)
    end

    unless current.x + 1 >= graph[0].length || visited.include?(graph[current.y][current.x + 1])
      graph[current.y][current.x + 1].setDistance([graph[current.y][current.x + 1].distance, current.distance + graph[current.y][current.x + 1].weight].min)
    end

    unless current.y + 1 >= graph.length || visited.include?(graph[current.y + 1][current.x])
      graph[current.y + 1][current.x].setDistance([graph[current.y + 1][current.x].distance, current.distance + graph[current.y + 1][current.x].weight].min)
    end

    visited << current
    unvisited.delete(current)
    current = unvisited.sort { |a, b| a.distance <=> b.distance }[0]
    if current == dest
      return current
    end
  end
end

graph.each do |line|
  line.each do |node|
    print node.weight
  end
  puts
end