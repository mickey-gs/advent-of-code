data = File.open('data.txt', 'r').readlines.map { |line| line[0..-2] }

total = data.length
sum = data[0].split('').map { 0 }
data.each do |line|
  line.split('').each_with_index do |ch, i|
    sum[i] += Integer(ch, 10)
  end
end

gamma = data[0].split('').map { '0' }.join
epsilon = gamma.dup
sum.each_with_index do |num, i|
  if num > total / 2
    gamma[i] = '1'
    epsilon[i] = '0'
  else
    gamma[i] = '0'
    epsilon[i] = '1'
  end
end

puts "binary => gamma: #{gamma}, epsilon: #{epsilon}"
puts "gamma: #{gamma.to_i(2)}, epsilon: #{epsilon.to_i(2)}, product: #{gamma.to_i(2) * epsilon.to_i(2)}"
