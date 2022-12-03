require "pry"

POSITIONS = File.open(ARGV[0]).readlines.map { |line| line.chomp[-1].to_i }

def one
	pos = POSITIONS.dup
	scores = [0, 0]
	turn = 0
	total_turns = 0
	while scores.max < 1000
		dice_roll = (3 * ((3 * turn) + 1)) + 3
		pos[turn % 2] = (pos[turn % 2] + dice_roll) % 10
		pos[turn % 2] = 10 if pos[turn % 2].zero?
		scores[turn % 2] += pos[turn % 2]
		turn = (turn % 100) + 1
		total_turns += 1
	end

	puts scores.min * total_turns * 3
end

def two
	games = {}

	(1..100).each do |score|
		(1..10).each do |pos|
			games[[score, pos]] = 0
		end
	end

	(1..3).each do |i|
		(1..3).each do |j|
			(1..3).each do |k|
				pos = POSITIONS[0].dup
				score = 0
				[i, j, k].each do |roll|
					pos = ((pos + roll - 1) % 10) + 1
					score += pos
				end
				games[[score, pos]] += 1
			end
		end
	end

	games.dup.each do |game, frequency|
		next if frequency == 0
		(1..3).each do |i|
					pos = game.dup[1]
					score = game.dup[0]

					[i].each do |roll|
						pos = ((pos + roll - 1) % 10) + 1
						score += pos
					end

					games[[score, pos]] += 1
			(1..3).each do |j|
					pos = game.dup[1]
					score = game.dup[0]

					[i, j].each do |roll|
						pos = ((pos + roll - 1) % 10) + 1
						score += pos
					end

					games[[score, pos]] += 1
				(1..3).each do |k|
					pos = game.dup[1]
					score = game.dup[0]

					[i, j, k].each do |roll|
						pos = ((pos + roll - 1) % 10) + 1
						score += pos
					end

					games[[score, pos]] += 1
				end
			end
		end
	end

	#break this up a bit- it should do 3 rolls, compare, a fourth, compare, etc.

	puts games.reduce(0) { |sum, (game, frequency)| sum + frequency } 
	#games.each do |game, frequency|
	#	p "#{game} => #{frequency}" unless frequency.zero?
	#end
end

two
