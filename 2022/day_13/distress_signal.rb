require "json"

DATA = File.open(ARGV[0], "r").readlines.map(&:chomp).map { |line| line == "" ? nil : JSON.parse(line) }.reject(&:nil?)

def in_order a, b
	return true if a.nil?
	return false if b.nil?
	if a.is_a?(Integer) && b.is_a?(Integer)
		return a <= b
	elsif a.is_a?(Array) && b.is_a?(Integer)
		return in_order(a, [b])
	elsif a.is_a?(Integer) && b.is_a?(Array)
		return in_order([a], b)
	else
		b.each.with_index do |right, i|
			next if a[i] == right || a[i] == [right]
			return in_order(a[i], right)
		end
		return b.length >= a.length
	end
end

def bubble_sort array
	loop do
		sorted = true
		(array.length - 1).times do |i|
			unless in_order(array[i], array[i + 1])
				store = array[i].dup
				array[i] = array[i + 1]
				array[i + 1] = store
				sorted = false
			end
		end
		break if sorted
	end
	return array
end

def one
	in_order_indices = []
	DATA.each_slice(2).with_index(1) do |(a, b), i|
		in_order_indices << i if in_order(a, b)
	end
	puts in_order_indices.sum
end

def two
	result = bubble_sort(DATA + [[[2]], [[6]]])
	puts((result.index([[2]]) + 1) * (result.index([[6]]) + 1))
end

one
two
