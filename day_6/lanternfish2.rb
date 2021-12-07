data = File.open('data.txt', 'r').readlines.map { |line| line.split(',') }
data = data.flatten.map(&:to_i)

at_each_age = [0, 0, 0, 0, 0, 0, 0, 0, 0]
data.each do |age|
  at_each_age[age] += 1
end

256.times do
  resets = at_each_age.shift
  at_each_age[6] += resets
  at_each_age.push(resets)
end

p at_each_age.sum
