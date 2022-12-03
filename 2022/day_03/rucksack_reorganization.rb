require "pry"
DATA = File.open(ARGV[0], "r").readlines.map(&:chomp).map { |bag| [bag[0..bag.length / 2 - 1].split(""), bag[bag.length / 2, bag.length].split("")] }

def priority ch
	return ch.ord - 38 if ch.ord <= 90
	return ch.ord - 96
end

def one
	p DATA.map { |bag| binding.pry if bag[0] & bag[1] == []; priority((bag[0] & bag[1])[0]) }.reduce(:+)
end

def two
	sum = 0
	DATA.each_slice(3) { |bags| sum += priority((bags[0].join.split("") & bags[1].join.split("") & bags[2].join.split(""))[0]) }
	p sum
end

one
two
