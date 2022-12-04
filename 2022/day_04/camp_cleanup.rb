DATA = File.open(ARGV[0], "r").readlines.map(&:chomp).map { |str| str.split "," }.map { |arr| arr.map { |half| Range.new(*(half.split("-").map(&:to_i))) } }

def one
	sum = 0
	DATA.each do |ranges|
		sum += 1 unless ranges[0].map { |section| ranges[1].include? section }.include?(false) && ranges[1].map { |section| ranges[0].include? section }.include?(false)
	end
	p sum
end

def two
	sum = 0
	DATA.each do |ranges|
		sum += 1 if ranges[0].map { |section| ranges[1].include? section }.include?(true) || ranges[1].map { |section| ranges[0].include? section }.include?(true)
	end
	p sum
end

one
two
