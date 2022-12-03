require 'pry'

class Node
  attr_reader :visited, :x, :y, :weight
  attr_accessor :f_score, :distance
  
  def initialize weight, x, y
    @visited = false
    @distance = 1_000_000_000
    @weight = weight
    @x = x
    @y = y
    @f_score = nil
  end

  def setDistance(distance) 
    @distance = distance
  end
end

def setup
  data = File.open("data.txt").readlines
    .map { |line| line.chomp.split("").map &:to_i }
  output = data.map { |line| line + Array.new(line.length * 4) }
  output += Array.new(data.length * 4) { Array.new { (data[0].length * 4) - 1 } }
  output.each.with_index do |line, row|
    output.each.with_index do |num, col|
      output[row][col] = data[row % data.length][col % data[0].length]
      output[row][col] += (row / data.length) + (col / data[0].length)
      output[row][col] %= 9
      output[row][col] += 9 if output[row][col] == 0
    end
  end
  output
end

graph = setup.map.with_index { |arr, y| arr.map.with_index { |weight, x| Node.new(weight, x, y) } }
current = graph[0][0]
current.setDistance(0)
dest = graph[-1][-1]

def heuristic node, graph
  (graph[0].length - node.x) * 5 + 5 * (graph.length - node.y)
end

def a_star(current, dest, graph)
  openSet = []
  current.f_score = heuristic current, graph
  while true
    (-1..1).each do |y|
      (-1..1).each do |x|
        next if x == y || (!x.zero? && !y.zero?)
        next if current.x + x < 0 || current.y + y < 0
        next if [current.x + x, current.y + y].include? graph.length

        considering = graph[current.y + y][current.x + x]
        tentative_dist = current.distance + considering.weight
        if tentative_dist < considering.distance
          graph[current.y + y][current.x + x].distance = tentative_dist
          graph[current.y + y][current.x + x].f_score = tentative_dist + heuristic(graph[current.y + y][current.x + x], graph)
          openSet << considering unless openSet.include? considering
        end
      end
    end

    openSet.delete(current)
    current = openSet.min { |a, b| a.distance <=> b.distance }
    if current == dest
      return current
    end
  end
end

p a_star(current, dest, graph)