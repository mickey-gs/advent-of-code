data = File.open('data.txt', 'r')
           .readlines
           .map { |line| line.chomp.split(',').map(&:to_i) }
           .flatten

total_dists = []
data.each.with_index do |pos0, i|
  total_dists[i] = 0
  data.each do |pos1|
    total_dists[i] += (pos0 - pos1).abs
  end
end

best_pos = data[total_dists.find_index(total_dists.min)]
fuel = 0
data.each do |pos|
  fuel += (best_pos - pos).abs
end
p fuel
