require "pry"

FILE_NAME = ARGV[0]
target_str = File.open(FILE_NAME).readlines[0].chomp
target_str = target_str.slice(13, target_str.length - 13).split(", ").map { |area| Range.new *(area[2..-1].split("..").map{ |pos| pos.to_i }) }
AREA = {x: target_str[0], y: target_str[1]}

def missed area, pos
	return pos[:x] > area[:x].max || pos[:y] < area[:y].min
end

def scored area, pos
	return area[:x].include?(pos[:x]) && area[:y].include?(pos[:y])
end

def score_shot area, vel, pos
	max_height = 0
	loop do
		return nil if missed area, pos
		return max_height if scored area, pos

		pos[:x] += vel[:x]
		pos[:y] += vel[:y]

		max_height = [max_height, pos[:y]].max

		vel[:y] -= 1
		vel[:x] = [vel[:x]-1, 0].max

	end
end

scores = []
(0..AREA[:x].max).each.reverse_each do |vel_x|
	(-1000..1000).each.reverse_each do |vel_y|
		scores << score_shot(AREA, {x: vel_x, y: vel_y}, {x: 0, y: 0})
	end
end

scores.reject! { |score| score.nil? }.length

puts "Answer 1: "
puts scores.sort.reverse[0]

puts "Answer 2: "
puts scores.length
