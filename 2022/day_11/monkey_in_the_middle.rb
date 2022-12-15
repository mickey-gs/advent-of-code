require "pry"
DATA = File.open(ARGV[0], "r").readlines.map(&:chomp)
$monkeys = []
DATA.each_slice(7).with_index do |monkey, i|
	$monkeys[i] = {}
	$monkeys[i][:items] = monkey[1].scan(/\d+/).map(&:to_i)
	$monkeys[i][:op] = monkey[2].scan(/=.+/)[0]
	$monkeys[i][:divisor] = monkey[3].scan(/\d+/)[0].to_i
	$monkeys[i][:receivers] = [monkey[4][-1].to_i, monkey[5][-1].to_i]
end

def one
	inspections = Array.new($monkeys.length) { 0 }
	20.times do |round|
		$monkeys.length.times do |i|
			until $monkeys[i][:items].empty?
				inspections[i] += 1
				item = $monkeys[i][:items].shift
				sign = $monkeys[i][:op].scan(/(\+|\*)/).flatten[0]
				op = $monkeys[i][:op].gsub "old", item.to_s
				item = op.scan(/\d+/).map(&:to_i).reduce(sign.to_sym) / 3
				recipient = item % $monkeys[i][:divisor] == 0 ? 0 : 1
				$monkeys[$monkeys[i][:receivers][recipient]][:items] << item
			end
		end
	end
	puts inspections.sort[-2..-1].reduce(:*)
end

def two
	inspections = Array.new($monkeys.length) { 0 }
	10_000.times do |round|
		$monkeys.length.times do |i|
			until $monkeys[i][:items].empty?
				inspections[i] += 1
				item = $monkeys[i][:items].shift
				sign = $monkeys[i][:op].scan(/(\+|\*)/).flatten[0]
				op = $monkeys[i][:op].gsub "old", item.to_s
				item = op.scan(/\d+/).map(&:to_i).reduce(sign.to_sym)
				item = [item, 10_000].max
				recipient = item % $monkeys[i][:divisor] == 0 ? 0 : 1
				$monkeys[$monkeys[i][:receivers][recipient]][:items] << item
			end
		end
	end
	puts inspections.sort[-2..-1].reduce(:*)
end

one
two
