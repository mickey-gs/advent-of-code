data = File.open('data.txt', 'r').readlines.map(&:chomp)

polymer = data[0]
rules = {}
data[2..-1].each do |line|
  line = line.split(' -> ')
  rules[line[0]] = line[1]
end

10.times do 
  temp = []

  polymer.split('').each_cons(2) do |one, two|
    inject = rules[one + two]
    temp << one << inject
  end
  temp << polymer[-1]

  polymer = temp.join('')
end

counter = {}
polymer.split('').each do |ch|
  counter[ch] = (counter[ch].nil? ? 1 : counter[ch] + 1)
end
puts counter.values.max - counter.values.min
