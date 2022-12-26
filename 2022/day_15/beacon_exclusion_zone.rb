require "set"
require "pry"

DATA = File.open(ARGV[0], "r").readlines.map(&:chomp).map { |line| line.scan(/-*[0-9]+/).map(&:to_i) }

def one
	cant = Set[]
	DATA.each do |sx, sy, bx, by|
		manhattan = (bx - sx).abs + (by - sy).abs
		d_y = (ARGV[1].to_i - sy).abs
		if d_y <= manhattan
			((manhattan - d_y) + 1).times do |i|
				cant.add(sx + i)
				cant.add(sx - i)
			end
			cant.delete bx if by == ARGV[1].to_i
			cant.delete sx if sy == ARGV[1].to_i
		end
	end
	puts cant.length
end

def two
	manhattans = DATA.map { |sx, sy, bx, by| (bx - sx).abs + (by - sy).abs }
	sensors = DATA.map { |sx, sy, _, _| [sx, sy] }
	4_000_000.times do |x|
		4_000_000.times do |y|
		end
	end
end

one
