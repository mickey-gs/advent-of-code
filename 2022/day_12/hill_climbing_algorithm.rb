require "matrix"
require "set"

DATA = File.open(ARGV[0], "r").readlines.map { |line| line.chomp.split("").map { |ch| ch == "S" || ch == "E" ?  ch : ch.ord - 97 } } 
DATA2 = File.open(ARGV[0], "r").readlines.map { |line| line.chomp.split("").map { |ch| ch == "S" || ch == "E" ?  ch : ch.ord - 97 } } 

def one
	start = nil
	goal = nil
	DATA.each.with_index do |line, y|
		line.each.with_index do |node, x|
			start = Vector[x, y] if node == "S"
			goal = Vector[x, y] if node == "E"
		end
	end

	DATA[start[1]][start[0]] = 0
	DATA[goal[1]][goal[0]] = 25

 	explored = Set[]
	queue = []
	parents = {}
 	queue.push start
	until queue.empty?
		todo = queue.shift
		break if todo == goal

		[-1, 0, 1].each do |d_y|
			[-1, 0, 1].each do |d_x|
				next if (d_y != 0 && d_x != 0) || (d_y == 0 && d_x == 0)

				adjacent = Vector[todo[0] + d_x, todo[1] + d_y]
				next if adjacent[1] >= DATA.length || adjacent[0] >= DATA[0].length || adjacent[1] < 0 || adjacent[0] < 0
				#binding.pry if adjacent == vector[0, -6]
				#p adjacent
				next if (DATA[adjacent[1]][adjacent[0]] > DATA[todo[1]][todo[0]] + 1) || explored.include?(adjacent)
				explored.add adjacent
				parents[adjacent] = todo
				queue.push adjacent
	   		end
		end
	end

	node = goal
	path = 0
	until node == start
		node = parents[node]
		path += 1
	end

	return path
end

def two
	starts = []
	goal = nil
	DATA2.each.with_index do |line, y|
		line.each.with_index do |node, x|
			starts << Vector[x, y] if node == 0
			goal = Vector[x, y] if node == "E"
			DATA2[y][x] = 0 if node == "S"
		end
	end

	DATA2[goal[1]][goal[0]] = 25

	paths = []
	starts.each do |start|
		explored = Set[]
		queue = []
		parents = {}
		queue.push start
		found = false
		until queue.empty?
			p queue
			todo = queue.shift
			if todo == goal then found = true; break end

			[-1, 0, 1].each do |d_y|
				[-1, 0, 1].each do |d_x|
					next if (d_y != 0 && d_x != 0) || (d_y == 0 && d_x == 0)

					adjacent = Vector[todo[0] + d_x, todo[1] + d_y]
					next if adjacent[1] >= DATA2.length || adjacent[0] >= DATA2[0].length || adjacent[1] < 0 || adjacent[0] < 0
					#binding.pry if adjacent == vector[0, -6]
					#p adjacent
					next if (DATA2[adjacent[1]][adjacent[0]] > DATA2[todo[1]][todo[0]] + 1) || explored.include?(adjacent)
					explored.add adjacent
					parents[adjacent] = todo
					queue.push adjacent
				end
			end
		end
		next unless found

		node = goal
		path = 0
		until node == start
			node = parents[node]
			path += 1
		end

		paths << path
	end

	return paths.sort[0]
end

puts one
puts two
