DATA = File.open(ARGV[0], "r").readlines.map(&:chomp)[0].split ""

def one
	DATA.each_cons(4).with_index do |str, i|
		if str.uniq.length == 4 then puts i + 4; return end
	end
end

def two
	DATA.each_cons(14).with_index do |str, i|
		if str.uniq.length == 14 then puts i + 14; return end
	end
end

one
two
