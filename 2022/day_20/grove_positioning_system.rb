require "pry"
DATA = File.open(ARGV[0], "r").readlines.map { |num| num.chomp.to_i }

def one
	order = Array.new(DATA.length) { |i| i }
	p DATA.length
	(DATA.length).times do |i|
		current = order.index(i)
		item = DATA[current]
		dest = (item + current + (item < 0 ? 0 : 1)) % (DATA.length - 1)
		origin = order.index(i)
		if dest.zero?
			DATA.push(item)
			DATA.delete_at(origin)
			order.push(current)
			order.delete_at(origin)
		elsif dest == DATA.length - 1
			DATA.unshift(item)
			DATA.delete_at(origin + 1)
			order.unshift(current)
			order.delete_at(origin + 1)
		else
			DATA.insert(dest, item) 
			DATA.delete_at(origin + (dest < origin ? 1 : 0))
			order.insert(dest, current)
			order.delete_at(origin + (dest < origin ? 1 : 0))
		end
	end
	zero_pos = DATA.index(0)
	p DATA.length
	p [DATA[(zero_pos + 1000) % DATA.length], DATA[(zero_pos + 2000) % DATA.length], DATA[(zero_pos + 3000) % DATA.length]]
	return [DATA[(zero_pos + 1000) % DATA.length], DATA[(zero_pos + 2000) % DATA.length], DATA[(zero_pos + 3000) % DATA.length]].sum
end

puts one
