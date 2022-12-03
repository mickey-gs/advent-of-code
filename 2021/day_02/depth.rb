data = File.open('data.txt', 'r').readlines

x = 0
y = 0
data = data.map { |line| line[0..-2].split(' ') }
data.each do |line|
  if line[0] == 'forward'
    x += Integer(line[1], 10)
    next
  end
  y += (line[0] == 'down' ? Integer(line[1], 10) : -Integer(line[1], 10))
end

puts "x: #{x}, y: #{y}, x*y: #{x * y}"
