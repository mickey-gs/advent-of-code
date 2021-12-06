data = File.open('data.txt', 'r').readlines.map { |line| line[0..-2] }

reps = data[0].length
o2 = data.dup
co2 = data.dup

reps.times do |i|
  sum = 0
  o2.each do |line|
    sum += Integer(line[i], 10)
  end

  total = o2.length
  puts "sum: #{sum}, total: #{total}"
  o2 = o2.select do |line|
    if o2.length == 1
      line
    elsif sum == total / 2
      line[i] == '1'
    else
      line[i] == (sum > total / 2 ? '1' : '0')
    end
  end

  sum = 0
  co2.each do |li|
    sum += Integer(li[i], 10)
  end

  total = co2.length
  puts "sum: #{sum}, total: #{total}"
  co2 = co2.select do |li|
    if co2.length == 1
      li
    elsif sum == total / 2
      li[i] == '0'
    else
      li[i] == ((sum < total / 2) ? '1' : '0')
    end
  end
end

p o2, co2
p o2[0].to_i(2) * co2[0].to_i(2)
