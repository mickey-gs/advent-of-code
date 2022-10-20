data = File.open('data.txt', 'r').readlines.map { |line| line.chomp.split('').map(&:to_i) }

risks = []
data.first.each.with_index do |height, i|
  if height < data[1][i]
    if (data.first[i-1].nil? || height < data.first[i-1]) &&
       (data.first[i+1].nil? || height < data.first[i+1])
      risks << height + 1
    end
  end
end

data.each_cons(3) do |above, line, below|
  line.each.with_index do |height, i|
    if height < above[i] && height < below[i]
      if (line[i-1].nil? || height < line[i-1]) && (line[i+1].nil? || height < line[i+1])
        risks << height + 1
      end
    end 
  end
end

data.last.each.with_index do |height, i|
  if height < data[-2][i]
    if (data.last[i-1].nil? || height < data.last[i-1]) &&
       (data.last[i+1].nil? || height < data.last[i+1])
      risks << height + 1
    end
  end
end

p risks.reduce(:+)