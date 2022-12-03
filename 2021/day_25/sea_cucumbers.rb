require "pry"

class TrueClass; def to_i; return 1 end end 
class FalseClass; def to_i; return 0 end end 

FILE_NAME = ARGV[0]
GRID = File.open(FILE_NAME).readlines.map { |line| line.chomp }

def right_clear grid, pos
	return grid[pos[:y]][0] == "." if pos[:x] == grid[0].length - 1
	return grid[pos[:y]][pos[:x] + 1] == "."
end

def down_clear grid, pos
	return grid[0][pos[:x]] == "." if pos[:y] == grid.length - 1
	return grid[pos[:y] + 1][pos[:x]] == "." 
end

def clear grid, pos, ch
	case (ch)
		when ">"
		return right_clear grid, pos

		when "v"
		return down_clear grid, pos

		when "."
		return 2
	end
end

grid = GRID.dup
1000000.times do |i|
previous = Marshal.load(Marshal.dump(grid))
swaps = []
grid.each.with_index do |line, y|
	line.split("").each.with_index do |ch, x|
		swaps.push({x: x, y: y}) if clear(grid, {x: x, y: y}, ch) && ch == ">"
	end
end

swaps.each do |pos|
	grid[pos[:y]][pos[:x]] = "."
	if pos[:x] == GRID[0].length - 1
		grid[pos[:y]][0] = ">"
	else
		grid[pos[:y]][pos[:x] + 1] = ">"
	end
end

swaps = []
grid.each.with_index do |line, y|
	line.split("").each.with_index do |ch, x|
		swaps.push({x: x, y: y}) if clear(grid, {x: x, y: y}, ch) && ch == "v"
	end
end

swaps.each do |pos|
	grid[pos[:y]][pos[:x]] = "."
	if pos[:y] == GRID.length - 1
		grid[0][pos[:x]] = "v"
	else
		grid[pos[:y] + 1][pos[:x]] = "v"
	end
end

if grid == previous
	p i + 1
	break
end
end

