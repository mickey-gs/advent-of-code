require "pry"

FILE = File.open(ARGV[0]).readlines.map { |line| line.chomp }
KEY = FILE[0]
PHOTO = FILE[2..-1]

hash = {}
PHOTO.each.with_index do |line, y|
	line.split("").each.with_index do |ch, x|
		hash[x: x, y: y] = true if ch == "#"
	end
end

def neighbours_to_string hash, key
	x = key[:x]
	y = key[:y]
	ret = ""
	[y - 1, y, y + 1].each do |y_i|
		[x - 1, x, x + 1].each do |x_i|
			ret += hash[x: x_i, y: y_i].nil? ? "0" : "1"
		end
	end
	
	return ret
end

def string_to_pixel string, picture_key
	return picture_key[string.to_i(2)]
end

def enhance hash, key, step
	output = {}
	(-10 * (step + 1)..PHOTO.length + (10 * (step + 1))).each do |y|
			(-10 * (step + 1)..PHOTO[0].length + (10 * (step + 1))).each do |x|
			string = neighbours_to_string hash, {x: x, y: y}
			pixel = string_to_pixel string, KEY
			output[x: x, y: y] = true if pixel == "#" && string != "0000000000"
		end
	end

	return output
end

def one hash
	puts((enhance(enhance(hash, KEY, 1), KEY, 2)).length)
end

one hash
