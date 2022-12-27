DATA = File.open(ARGV[0], "r").readlines.map { |num| num.chomp.to_i }

def one array
	orders = Array.new(array.length) { |i| i }
	(array.length).times do |i|
		current_pos = orders.index(i)
		current_num = array[current_pos]
		array.delete_at(current_pos)
		dest = (current_num + current_pos) % array.length
		array.insert(dest, current_num)
		orders.delete_at(current_pos)
		orders.insert(dest, i)
	end
	zero_pos = array.index(0)
	return [array[(zero_pos + 1000) % array.length], array[(zero_pos + 2000) % array.length], array[(zero_pos + 3000) % array.length]].sum
end

def two array
	orders = Array.new(array.length) { |i| i }
	array.map! { |num| num * 811589153 }
	10.times do
		(array.length).times do |i|
			current_pos = orders.index(i)
			current_num = array[current_pos]
			array.delete_at(current_pos)
			dest = (current_num + current_pos) % array.length
			array.insert(dest, current_num)
			orders.delete_at(current_pos)
			orders.insert(dest, i)
		end
	end
	zero_pos = array.index(0)
	return [array[(zero_pos + 1000) % array.length], array[(zero_pos + 2000) % array.length], array[(zero_pos + 3000) % array.length]].sum
end

puts one(DATA.dup)
puts two(DATA.dup)
