DATA = File.open(ARGV[0], "r").readlines.map(&:chomp)

def parse str
	sum = 0
	str.reverse.split("").each.with_index do |ch, i|
		digit = 0
		if ch == "-"
			digit = -1
		elsif ch == "="
			digit = -2
		else
			digit = ch.to_i
		end
		sum += digit * (5 ** i)
	end
	sum
end

def reverse_parse num
	digits = %w( 0 1 2 = - )
	upper_power = Math::log(num, 5).ceil
	count_down = Array.new(upper_power) { -2 }
	count_down[-1] = 2
	current_col = -2
	loop do
		break if magnitude(count_down) == num
		loop do
			count_down[current_col] += 1
			if magnitude(count_down) > num then count_down[current_col] -= 1; break end
		end
		current_col -= 1
	end
	count_down.map { |x| digits[x] }.reverse
end

def magnitude arr
	arr.each.with_index.reduce(0) { |sum, (val, i)| sum + ((5 ** i) * val) }
end

def one
	reverse_parse(DATA.map { |num| parse(num) }.sum)
end

puts one.join
