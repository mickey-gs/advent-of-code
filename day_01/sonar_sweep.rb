# frozen_string_literal: true

array = []
data = File.open('data.txt', 'r').readlines
data.each { |line| array.push(Integer(line[0...-1], 10)) }

count = 0
previous = array[0]
array.each do |elem|
  next if elem == array[0]

  count += 1 if elem > previous

  previous = elem
end

puts count
