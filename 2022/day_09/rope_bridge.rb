require "matrix"

dirs = { "U" => Vector[0, 1], "D" => Vector[0, -1], "R" => Vector[1, 0], "L" => Vector[-1, 0] }
DATA = File.open(ARGV[0], "r").readlines.map { |line| line.chomp.split " " }.map { |line| [dirs[line[0]], line[1].to_i] }

def one
	visited = []
	tail = head = Vector[0, 0]
	DATA.each do |move|
		move[1].times do 
			head += move[0]
			if (head - tail).r >= 1.5
				tail += move[0]
				if tail[0] != head[0] && tail[1] != head[1]
					if move[0][0].zero? then tail[0] = head[0] else tail[1] = head[1] end
				end
			end
			visited << tail
		end
	end
	puts visited.uniq.length
end

def two
	visited = []
	knots = Array.new (10) { |_| Vector[0, 0] }
	DATA.each do |move|
		move[1].times do 
			knots[0] += move[0]
			i = 0
			while i < knots.length
				if i == 0 then i += 1; next end

				displacement = (knots[i-1] - knots[i])
				
				if displacement[0].abs > 1 || displacement[1].abs > 1
					knots[i] += displacement.map { |val| val.zero? ? 0 : (val < 0 ? -1 : 1) }
				end
				
				i += 1
			end
			visited << knots[-1]
		end
	end
	puts visited.uniq.length
end

one
two
