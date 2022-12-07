DATA = File.open(ARGV[0], "r").readlines.map(&:chomp).map { |line| line.scan(/[^\s\$]+/) }.reject { |line| line == ["ls"] }

def calc_size node
	return node.reduce(0) do |sum, (key, val)|
		if key == :size then sum + val else sum + calc_size(val) end
	end
end

def calc_sizes node, sizes = []
	node.each_pair do |key, val|
		next if val.is_a? Integer
		sizes << calc_size(val)
		calc_sizes val, sizes
	end
	sizes
end

root = {}
pwd = [root]
DATA[1..-1].each do |line|
	pwd[-1][line[1]] = {} if line[0] == "dir"

	unless line[0].to_i.zero?
		pwd[-1][:size] = (pwd[-1][:size].nil? ? line[0].to_i : pwd[-1][:size] + line[0].to_i)
	end

	if line[0] == "cd"
		if line[1] == ".." then pwd.pop
		else pwd.push pwd[-1][line[1]] end
	end
end

def one root
	p calc_sizes(root).reduce(0) { |sum, size| sum + (size <= 100_000 ? size : 0) }
end

def two root
	needed = 30_000_000
	total = 70_000_000
	unused = total - calc_size(root)
	to_delete = needed - unused
	candidates = calc_sizes(root).reject { |size| size < to_delete}
	p candidates.min
end

one root
two root
