DATA = File.open(ARGV[0], "r").readlines.map { |line| line.chomp.scan(/-*\d+/)[0] }.map { |val| val.nil? ? nil : val.to_i }

def one
	cycle = 0
	register = 1
	signals = 0
	DATA.each do |instruction|
		cycle += 1
		signals += cycle * register if (cycle - 20) % 40 == 0
		next if instruction.nil?
		cycle += 1
		signals += cycle * register if (cycle - 20) % 40 == 0
		register += instruction
	end
	puts signals
end

def two
	picture = Array.new(6) { [] }
	cycle = 1
	register = 1
	DATA.each do |instruction|
		picture[(cycle - 1) / 40] << ([register-1, register, register+1].include?((cycle - 1) % 40) ? "#" : ".")
		cycle += 1
		next if instruction.nil?
		picture[(cycle - 1) / 40] << ([register-1, register, register+1].include?((cycle - 1) % 40) ? "#" : ".")
		register = (register + instruction) % 40
		cycle += 1
	end
	picture.each { |line| puts line.join "" }
end

one
two
