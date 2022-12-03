require "pry"

NUMBERS = File.open(ARGV[0]).readlines.map { |line| line.chomp }

def magnitude node
	return node if node.class == Integer
	return (3 * magnitude(node[:left])) + (2 * magnitude(node[:right]))
end

def create_tree string
	return string.to_i unless string.include? ","

	nest_level = 0
	pivot = 0

	string.split("").each.with_index do |char, i|
		nest_level += 1 if char == "["
		nest_level -= 1 if char == "]"

		pivot = i if nest_level == 1 && char == ","
	end

	tree = {}
	tree[:left] = create_tree(string[1..pivot-1])
	tree[:right] = create_tree(string[pivot+1..-2])

	return tree
end

def detect_explode node, level = 0, path = []
	return nil if node.class == Integer
	return path if level == 4 && node.class != Integer

	temp_path = detect_explode(node[:left], level + 1, path + [:left]) unless node.class == Integer || node[:left].nil?
	return temp_path unless temp_path.nil?

	temp_path = detect_explode(node[:right], level + 1, path + [:right]) unless node.class == Integer || node[:right].nil?
	return temp_path unless temp_path.nil?
end

def detect_split node, path = []
	return nil if node.class == Integer && node < 10
	return path if node.class == Integer && node >= 10

	temp_path = detect_split(node[:left], path + [:left]) unless node.class == Integer || node[:left].nil?
	return temp_path unless temp_path.nil?

	temp_path = detect_split(node[:right], path + [:right]) unless node.class == Integer || node[:right].nil?
	return temp_path unless temp_path.nil?
end

def find_left_neighbour tree, path
	while turn = path.pop
		break if turn == :right
		return nil if path.empty?
	end
	path << :left

	loop do
		return path if tree.dig(*path).class == Integer
		path << :right
	end

	return path
end

def find_right_neighbour tree, path
	while turn = path.pop
		break if turn == :left
		return nil if path.empty?
	end
	path << :right

	loop do
		return path if tree.dig(*path).class == Integer
		path << :left
	end

	return path
end

def explode tree, path
	left_path = find_left_neighbour tree, path.dup
	unless left_path.nil?
		tree.dig(*left_path[0..-2])[left_path[-1]] += tree.dig(*path)[:left]
	end

	right_path = find_right_neighbour tree, path.dup
	unless right_path.nil?
		tree.dig(*right_path[0..-2])[right_path[-1]] += tree.dig(*path)[:right]
	end

	tree.dig(*path[0..-2])[path[-1]] = 0

	return tree
end

def split tree, path
	val = tree.dig(*path)
	last_turn = path[-1]
	tree.dig(*path[0..-2])[last_turn] = {left: (val/2.0).floor, right: (val/2.0).ceil}
	return tree
end

def main tree
	loop do
		if path = detect_explode(tree)
			explode(tree, path)
			next
		end

		if path = detect_split(tree)
			split(tree, path)
			next
		end

		break
	end 

	return tree
end

def one
	tree = main({left: create_tree(NUMBERS[0]), right: create_tree(NUMBERS[1])})
	NUMBERS[2..-1].each do |number|
		tree = main({left: tree, right: create_tree(number)})
	end
	puts magnitude(tree)
end

def two
	results = []
	NUMBERS.each do |x|
		NUMBERS.each do |y|
			results << magnitude(main({left: create_tree(x), right: create_tree(y)})) unless x == y
		end
	end
	puts results.max
end

two
