data = File.open('data.txt', 'r').readlines.map { |line| line.chomp.split('-') }

def duplicates(history)
  counter = {}
  history.each do |node|
    counter[node] = (counter[node].nil? ? 1 : counter[node] + 1)
  end

  counter.each do |key, value|
    if key.downcase == key && value == 2
      return true
    end
  end

  false
end

class Node
  @@paths = 0
  @name = ''
  @nodes = []

  def initialize(name, nodes)
    @name = name
    @nodes = nodes
  end

  def attach(node)
    @nodes << node
  end

  def major?
    @name.upcase == @name
  end

  def minor?
    @name.downcase == @name
  end

  def self.paths
    @@paths
  end

  def find_paths(history)
    history << @name

    if @name == 'end'
      @@paths += 1
      return
    end

    @nodes.each do |node|
      unless history[-1] == node.name || node.name == 'start'
        if node.name.downcase == node.name
          if !duplicates(history) || !history.include?(node.name)
            node.find_paths(history.dup)
          end
        else
          node.find_paths(history.dup)
        end
      end
    end
  end 

  attr_reader :name, :nodes, :paths
end

nodes = {}
data.each do |edge|
  edge.each do |node|
    nodes[node] = Node.new(node, []) if nodes[node].nil?
  end
end

data.each do |edge|
  nodes[edge[0]].attach(nodes[edge[1]])
  nodes[edge[1]].attach(nodes[edge[0]])
end

nodes['start'].find_paths([])
p Node.paths