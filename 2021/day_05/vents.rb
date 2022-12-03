data = File.open('data.txt', 'r').readlines
           .map { |line| line.chomp.gsub('->', ',').split(',').map(&:to_i) }

grid = Array.new(1000) { Array.new(1000) { 0 } }

data.each do |points|
  if points[0] == points[2]
    order = (points[1] < points[3] ? [1, 3] : [3, 1])
    (points[order[1]] + 1).times do |num|
      next if num < points[order[0]]

      grid[points[0]][num] += 1
    end
  elsif points[1] == points[3]
    order = (points[0] < points[2] ? [0, 2] : [2, 0])
    (points[order[1]] + 1).times do |num|
      next if num < points[order[0]]

      grid[num][points[1]] += 1
    end
  end
end

sum = 0
grid.each do |line|
  line.each do |elem|
    sum += 1 if elem > 1
  end
end
p sum
