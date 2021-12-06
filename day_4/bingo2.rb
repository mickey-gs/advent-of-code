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

loser = nil
done = false
final_num = -1
numbers.each do |num|
  squares = squares.map { |sq| sq.map { |line| line.map { |e| e == num ? -1 : e } } }
  squares.each do |square|
    if check_for_win(square)
      if squares.length == 1
        loser = squares[0]
        done = true
        final_num = num
        break
      else
        squares = squares.reject { |sq| sq == square }
      end
    end
  end
  break if done
end

total = 0
loser.each do |line|
  p line
  line.each { |e| total += e unless e == -1 }
end
p total, total * final_num
