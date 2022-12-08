DATA = File.open(ARGV[0], "r").readlines.map { |line| line.chomp.split("").map(&:to_i) }

def one
	visible = 0
	DATA.each.with_index do |line, y|
		line.each.with_index do |tree, x|
			if x == 0 || line[0..x-1].max < tree || x == DATA[0].length - 1 || line[x+1..-1].max < tree
				visible += 1
			else 
				column = Array.new(DATA.length) { |i| DATA[i][x] } 
				if y == 0 || column[0..y-1].max < tree || y == DATA.length - 1 || column[y+1..-1].max < tree then visible += 1 end
			end
		end
	end
	p visible
end

def two
	high_score = 0
	DATA.each.with_index do |line, y|
		line.each.with_index do |tree, x|
			score = [0, 0, 0, 0]
			unless x.zero? 
				line[0..x-1].reverse_each do |other_tree|
					score[0] += 1
					break if other_tree >= tree
				end
			end

			unless x == DATA[0].length - 1 
				line[x+1..-1].each do |other_tree|
					score[1] += 1
					break if other_tree >= tree
				end
			end

			column = Array.new(DATA.length) { |i| DATA[i][x] }
			unless y.zero? 
				column[0..y-1].reverse_each do |other_tree|
					score[2] += 1
					break if other_tree >= tree
				end
			end

			unless y == DATA.length  
				column[y+1..-1].each do |other_tree|
					score[3] += 1
					break if other_tree >= tree
				end
			end

			high_score = [score.reduce(1) {|sum, tree| sum * tree }, high_score].max
		end
	end
	p high_score
end

one
two
