data = File.open('data.txt', 'r').readlines.map { |line| line.chomp }

o2 = data.dup
co2 = data.dup

i = 0
while o2.length > 1
  ones = o2.reduce(0) { |sum, num| sum + num[i].to_i }
  if ones >= o2.length / 2.0
    o2 = o2.select { |num| num[i] == '1' }
  else
    o2 = o2.select { |num| num[i] == '0' }
  end
  i += 1
end

i = 0
while co2.length > 1
  ones = co2.reduce(0) { |sum, num| sum + num[i].to_i }
  if ones >= co2.length / 2.0
    co2 = co2.select { |num| num[i] == '0' }
  else
    co2 = co2.select { |num| num[i] == '1' }
  end
  i += 1
end

p o2[0].to_i(2) * co2[0].to_i(2)
