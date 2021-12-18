data = File.open('data.txt', 'r').readlines.map(&:chomp)

rules = {}
data[2..-1].each do |line|
  line = line.split(' -> ')
  rules[line[0]] = line[1]
end

polymer = {}
rules.each do |key, value|
  polymer[key] = 0
  polymer[key[0] + value] = 0
  polymer[value + key[1]] = 0
end

counter = {}
data[0].split('').each_cons(2) do |a, b|
  polymer[a + b] += 1
  counter[a] = (counter[a].nil? ? 1 : counter[a] + 1)
end
counter[data[0][-1]] = (counter[data[0][-1]].nil? ? 1 : counter[data[0][-1]] + 1)

40.times do
  copy = polymer.dup

  polymer.each do |pattern, count|
    copy[pattern[0] + rules[pattern]] += count
    copy[rules[pattern] + pattern[1]] += count
    copy[pattern] -= count
    counter[rules[pattern]] = (counter[rules[pattern]].nil? ? count : counter[rules[pattern]] + count)
  end

  polymer = copy
end

puts counter.values.max - counter.values.min
