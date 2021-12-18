data = File.open('data.txt').readlines.map do |line|
  line.chomp.split(',').map(&:to_i)
end

instructions = File.open('data.txt', 'r').readlines[data.find_index([]) + 1..-1].map do |line|
  line.chomp[line.split('').find_index('=') - 1..-1].split('=').map { |e| e.to_i.zero? ? e : e.to_i }
end

data = data[0..data.find_index([]) - 1]

x_max = 0
y_max = 0
data.each do |coords|
  x_max = (coords[0] > x_max ? coords[0] : x_max)
  y_max = (coords[1] > y_max ? coords[1] : y_max)
end

grid = Array.new(y_max + 1) { Array.new(x_max + 1) { '.' } }

data.each do |coords|
  grid[coords[1]][coords[0]] = '#'
end

instructions.each do |fold|
  if fold[0] == 'y'
    grid[fold[1]..-1].each.with_index do |line, y|
      line.each.with_index do |elem, x|
        grid[fold[1] - y][x] = elem if elem == '#'
      end
    end

    grid = grid[0..fold[1]]
  else
    grid.each.with_index do |line, y|
      line[fold[1]..-1].each.with_index do |elem, x|
        grid[y][fold[1] - x] = elem if elem == '#'
      end

      grid[y] = line[0..fold[1]]
    end
  end
end

output = File.open('output.txt', 'w')
grid.each do |line| 
  line.each do |e| 
    output.print e
  end
  output.puts
end
