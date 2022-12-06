DATA = File.open(ARGV[0], "r").readlines.map(&:chomp)
STACKS = DATA[0..DATA.index("") - 1]
STEPS = DATA[DATA.index("") + 1..-1]

def gen_stacks
	stacks = []
	STACKS[-1].split("").each.with_index do |ch, i|
		next if ch == " "
		stacks[ch.to_i - 1] = []
		STACKS[0..-2].each { |line| stacks[ch.to_i - 1].push line[i] unless line[i] == " " }
	end
	stacks
end

def one stacks
	STEPS.each do |step|
		quantity, start, dest = step.scan(/\d+/).map(&:to_i)
		stacks[dest-1].unshift(*stacks[start-1].slice!(0, quantity).reverse)
	end
	puts stacks.reduce("") { |str, stack| str + stack[0] }
end

def two stacks
	STEPS.each do |step|
		quantity, start, dest = step.scan(/\d+/).map(&:to_i)
		stacks[dest-1].unshift(*stacks[start-1].slice!(0, quantity))
	end
	puts stacks.reduce("") { |str, stack| str + stack[0] }
end

one gen_stacks
two gen_stacks
