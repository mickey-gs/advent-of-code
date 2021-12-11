require 'pry'

data = File.open('data.txt').readlines.map(&:chomp)

openers = { ')' => '(', ']' => '[', '}' => '{', '>' => '<' }
data.each.with_index do |line, i|
  history = []
  line.split('').each do |ch|
    case ch
    when ')', ']', '}', '>'
      unless history.pop == openers[ch]
        data[i] = nil
        break
      end
    else
      history << ch
    end
  end
end

histories = []
data.each do |line|
  next if line.nil?

  history = []
  line.split('').each do |ch|
    case ch
    when ')', ']', '}', '>'
      history.pop
    else
      history << ch
    end
  end
  histories << history
end

points = { '(' => 1, '[' => 2, '{' => 3, '<' => 4 }
scores = []
histories.each do |history|
  score = 0
  history.reverse.each do |ch|
    score *= 5
    score += points[ch]
  end
  scores << score
end

p scores.sort[scores.length / 2]
