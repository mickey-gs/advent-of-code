# frozen_string_literal: true

array = []
data = File.open('data.txt', 'r').readlines
data.each { |line| array.push(Integer(line[0...-1], 10)) }

count = 0
array.each_cons(4) do |a, b, c, d|
  p [b, c, d]
  count += 1 if [b, c, d].sum > [a, b, c].sum
end

puts count
