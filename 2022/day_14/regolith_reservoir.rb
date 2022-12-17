require "matrix"
MAP = {}
File.open(ARGV[0], "r").readlines.map(&:chomp).each do |line|
	rock_path = line.split(" -> ").map { |rock| rock.split(",").map(&:to_i) }
	prev = rock_path[0]
	rock_path[1..-1].each do |rock|
		if rock[0] != prev[0]
			Range.new(*[rock[0], prev[0]].sort).each do |x|
				binding.pry if [x, rock[1]] == [503, 9]
				MAP[Vector[x, rock[1]]] = true
			end
		else
			Range.new(*[rock[1], prev[1]].sort).each do |y|
				binding.pry if [rock[0], y] == [503, 9]
				MAP[Vector[rock[0], y]] = true
			end
		end
		prev = rock
	end
end
backup = MAP.dup

def one map
	lowest = map.keys.sort { |a, b| a[1] <=> b[1] }[-1][1]
	units = 0
	loop do
		sand = Vector[500, 0]
		loop do
			return units if sand[1] > lowest + 1
			unless map[sand + Vector[0, 1]] then sand += Vector[0, 1]; next end
			unless map[sand + Vector[-1, 1]] then sand += Vector[-1, 1]; next end
			unless map[sand + Vector[1, 1]] then sand += Vector[1, 1]; next end
			map[sand] = true
			units += 1
			break
		end
	end
end

def two map
	lowest = map.keys.sort { |a, b| a[1] <=> b[1] }[-1][1] + 2
	units = 0
	loop do
		sand = Vector[500, 0]
		loop do
			return units if map[Vector[500, 0]]
			unless map[sand + Vector[0, 1]] || (sand + Vector[0, 1])[1] == lowest then sand += Vector[0, 1]; next end
			unless map[sand + Vector[-1, 1]] || (sand + Vector[-1, 1])[1] == lowest then sand += Vector[-1, 1]; next end
			unless map[sand + Vector[1, 1]] || (sand + Vector[1, 1])[1] == lowest then sand += Vector[1, 1]; next end
			map[sand] = true
			units += 1
			break
		end
	end
end

puts one(MAP.dup)
puts two(MAP.dup)
