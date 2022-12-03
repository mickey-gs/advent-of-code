data = File.open('data.txt', 'r').readlines
           .map { |line| line.chomp.gsub('->', ',').split(',').map(&:to_i) }

grid = Array.new(1000) { Array.new(1000) { 0 } }

data.each do |points|
  # smaller x co-ordinate
  xy = (points[0] <= points[2] ? [points[0], points[1]] : [points[2], points[3]])
  # larger x co-ordinate
  x1y1 = (points[0] <= points[2] ? [points[2], points[3]] : [points[0], points[1]])

  length = (xy[0] == x1y1[0] ? x1y1[1] - xy[1] : x1y1[0] - xy[0]).abs + 1
  if xy[0] == x1y1[0]
    length.times do |i|
      y = (xy[1] < x1y1[1] ? xy[1] : x1y1[1])
      grid[xy[0]][y + i] += 1
    end
  elsif xy[1] == x1y1[1]
    length.times do |i|
      grid[xy[0] + i][xy[1]] += 1
    end
  elsif x1y1[1] > xy[1]
    length.times do |i|
      grid[xy[0] + i][xy[1] + i] += 1
    end
  elsif x1y1[1] < xy[1]
    length.times do |i|
      grid[xy[0] + i][xy[1] - i] += 1
    end
  else
    puts 'uh oh'
  end
end

sum = 0
grid.reverse.each do |line|
  line.each do |elem|
    sum += 1 if elem > 1
  end
end
puts "sum: #{sum}"
