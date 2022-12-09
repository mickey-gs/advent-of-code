require "matrix"
require "set"

dirs = { "U" => Vector[0, 1], "D" => Vector[0, -1], "R" => Vector[1, 0], "L" => Vector[-1, 0] }
DATA = File.open(ARGV[0], "r").readlines.map { |line| line.chomp.split " " }.map { |line| [dirs[line[0]], line[1].to_i] }

def one
	visited = Set[]
	tail = head = Vector[0, 0]
	DATA.each do |move|
		move[1].times do 
			head += move[0]
			displacement = head - tail
			if displacement[0].abs > 1 || displacement[1].abs > 1
				tail += displacement.map { |val| val.zero? ? 0 : (val < 0 ? -1 : 1) }
			end
			visited.add tail
		end
	end
	puts visited.length
end

def two
	visited = Set[]
	knots = Array.new (10) { |_| Vector[0, 0] }
	DATA.each do |move|
		move[1].times do 
			knots[0] += move[0]
			i = 0
			while i < knots.length
				if i == 0 then i += 1; next end

				displacement = knots[i-1] - knots[i]
				if displacement[0].abs > 1 || displacement[1].abs > 1
					knots[i] += displacement.map { |val| val.zero? ? 0 : (val < 0 ? -1 : 1) }
				end
				
				i += 1
			end
			visited.add knots[-1]
		end
	end
	puts visited.length
end

one
two
