data = File.open('data.txt', 'r').readlines.map(&:chomp)
data = data.map do |line|
  line.split('|').map { |half| half.split(' ') }
end

unique = data.reduce(0) do |total, line|
  total + line[1].reduce(0) do |sum, output|
    if [2, 3, 4, 7].include? output.length
      sum + 1
    else
      sum + 0
    end
  end
end

p unique
