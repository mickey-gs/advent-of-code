DATA = File.open(ARGV[0], "r").readlines.map(&:chomp).map { |play| play.split " " }
MOVES = {"X" => 0, "A" => 0, "Y" => 1, "B" => 1, "Z" => 2, "C" => 2}
VALUES = {"X" => 1, "Y" => 2, "Z" => 3}

def one
	score = 0
	DATA.each do |round|
		score += VALUES[round[1]]
		if MOVES[round[0]] == MOVES[round[1]] then score += 3 
		elsif MOVES[round[0]] == (MOVES[round[1]] - 1) % 3 then score += 6 end
	end
	p score
end

def two
	score = 0
	results = {"X" => 0, "Y" => 3, "Z" => 6}
	DATA.each do |round|
		score += results[round[1]]
		if round[1] == "X" then score += ((MOVES[round[0]] - 1) % 3) + 1
		elsif round[1] == "Y" then score += MOVES[round[0]] + 1
		else score += ((MOVES[round[0]] + 1) % 3) + 1 end
	end
	p score
end

one
two
