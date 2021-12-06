data = File.open('data.txt', 'r').readlines.map(&:strip)
numbers = data[0].split(',').map(&:to_i)

def check_for_win(sq)
  sq.each do |line|
    count = 0
    line.each do |num|
      break if num != -1

      count += 1
    end
    return true if count == 5
  end

  sq.length.times do |i|
    count = 0
    sq.each do |line|
      break if line[i] != -1

      count += 1
    end
    return true if count == 5
  end

  false
end

i = 0
squares = []
squares[0] = []
data[2...data.length].each do |line|
  if line != ''
    squares[i] << line.split(' ').map(&:to_i)
  else
    squares[i + 1] = []
    i += 1
  end
end

winner = nil
done = false
final_num = -1
numbers.each do |num|
  squares = squares.map { |sq| sq.map { |line| line.map { |e| e == num ? -1 : e } } }
  squares.each do |square|
    next unless check_for_win(square)

    winner = square
    done = true
    final_num = num
  end
  break if done
end

total = 0
winner.each do |line|
  p line
  line.each { |e| total += e unless e == -1 }
end
p total, total * final_num
