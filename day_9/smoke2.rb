data = File.open('sample.txt', 'r').readlines.map { |line| line.chomp.split('').map(&:to_i) }

lows = []
data.first.each.with_index do |height, i|
  if height < data[1][i]
    if (data.first[i-1].nil? || height < data.first[i-1]) &&
       (data.first[i+1].nil? || height < data.first[i+1])
      lows << height + 1
    end
  end
end

data.each_cons(3) do |above, line, below|
  line.each.with_index do |height, i|
    if height < above[i] && height < below[i]
      if (line[i-1].nil? || height < line[i-1]) && (line[i+1].nil? || height < line[i+1])
        lows << height + 1
      end
    end 
  end
end

data.last.each.with_index do |height, i|
  if height < data[-2][i]
    if (data.last[i-1].nil? || height < data.last[i-1]) &&
       (data.last[i+1].nil? || height < data.last[i+1])
      lows << height + 1
    end
  end
end

# so have a point.
# search in all directions from that point.
# if they're not 9s or nil, search again from those points (but not the direction they just came from)
# , and add them to the basins[[]]

def basin_search(map, point, origin_dir, visited, basin)
  y = point[0]
  x = point[1]

  visited << [y, x]

  return basin if x < 0 || y < 0

  p point
  basin << map[y][x]
  unless origin_dir == :up || (y - 1).negative? || map[y - 1][x] == 9
    basin += basin_search(map, [y - 1, x], :down, visited, basin) unless visited.include? [y - 1, x]
  end

  unless origin_dir == :down || map[y + 1][x].nil? || map[y + 1][x] == 9
    basin += basin_search(map, [y + 1, x], :up, visited, basin) unless visited.include? [y + 1, x]
  end
  
  unless origin_dir == :left || (x - 1).negative? || map[y][x - 1] == 9
    basin += basin_search(map, [y, x - 1], :right, visited, basin) unless visited.include? [y, x - 1]
  end
  
  unless origin_dir == :right || map[y][x + 1].nil? || map[y][x + 1] == 9
    basin += basin_search(map, [y, x + 1], :left, visited, basin) unless visited.include? [y, x + 1]
  end

  visited
end

p basin_search(data, [0, 9], :up, [], [])