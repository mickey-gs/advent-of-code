data = File.open('data.txt', 'r').readlines.map { |line| line.chomp.split('').map(&:to_i) }

lows = []
data.first.each.with_index do |height, i|
  if height < data[1][i]
    if (data.first[i-1].nil? || height < data.first[i-1]) &&
       (data.first[i+1].nil? || height < data.first[i+1])
      lows << [0, i]
    end
  end
end

j = 1
data.each_cons(3) do |above, line, below|
  line.each.with_index do |height, i|
    if height < above[i] && height < below[i]
      if (line[i-1].nil? || height < line[i-1]) && (line[i+1].nil? || height < line[i+1])
        lows << [j, i]
      end
    end 
  end
  j += 1
end

data.last.each.with_index do |height, i|
  if height < data[-2][i]
    if (data.last[i-1].nil? || height < data.last[i-1]) &&
       (data.last[i+1].nil? || height < data.last[i+1])
      lows << [data.length - 1, i]
    end
  end
end

# so have a point.
# search in all directions from that point.
# if they're not 9s or nil, search again from those points (but not the direction they just came from)
# , and add them to the basins[[]]

def basin_search(map, point, origin_dir, visited)
  y = point[0]
  x = point[1]

  visited << [y, x]

  unless origin_dir == :up || (y - 1).negative? || map[y - 1][x] == 9
    basin_search(map, [y - 1, x], :down, visited) unless visited.include? [y - 1, x]
  end

  unless origin_dir == :down || map[y + 1].nil? || map[y + 1][x] == 9
    basin_search(map, [y + 1, x], :up, visited) unless visited.include? [y + 1, x]
  end
  
  unless origin_dir == :left || (x - 1).negative? || map[y][x - 1] == 9
    basin_search(map, [y, x - 1], :right, visited) unless visited.include? [y, x - 1]
  end
  
  unless origin_dir == :right || map[y][x + 1].nil? || map[y][x + 1] == 9
    basin_search(map, [y, x + 1], :left, visited) unless visited.include? [y, x + 1]
  end

  visited
end

basins = []
lows.each do |low|
  basins << basin_search(data, low, :up, []).length
end

p basins.sort.reverse[0..2].reduce(:*)
