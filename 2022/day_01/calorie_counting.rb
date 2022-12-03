DATA = File.open(ARGV[0], "r").readlines.map(&:chomp).map(&:to_i)

def gen_data
	totals = []
	i = 0
	DATA.each do |cal|
		totals[i] = (totals[i].nil? ? cal : totals[i] + cal)
		i += 1 if cal.zero?
	end
	return totals
end

def one
	p gen_data().max
end

def two
	p(gen_data().sort.reverse[0..2].sum)
end

one
two
