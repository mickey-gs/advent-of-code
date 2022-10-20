data = File.open('data.txt', 'r')
           .readlines
           .map { |line| line.chomp.split(',').map(&:to_i) }
           .flatten

def sigma(int)
  (1..int).sum
end

total_dists = []
1000.times do |start|
  total_dists[start] = 0
  data.each do |finish|
    total_dists[start] += sigma((start - finish).abs)
  end
end

best_pos = total_dists.find_index(total_dists.min)
fuel = 0
data.each do |pos|
  # p sigma((best_pos - pos).abs)
  # puts "#{pos} to #{best_pos}: #{sigma((best_pos - pos).abs)} fuel"
  fuel += sigma((best_pos - pos).abs)
end
p best_pos, fuel
