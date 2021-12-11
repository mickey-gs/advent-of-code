require 'pry'

data = File.open('data.txt').readlines.map(&:chomp)

corrupt = []
openers = { ')' => '(', ']' => '[', '}' => '{', '>' => '<' }
data.each do |line|
  history = []
  line.split('').each do |ch|
    case ch
    when ')', ']', '}', '>'
      unless history.pop == openers[ch]
        corrupt << ch
        break
      end
    else
      history << ch
    end
  end
end

scores = { '(' => 3, '[' => 57, '{' => 1197, '<' => 25_137 }
sum = 0
corrupt.each do |ch|
  sum += case ch
         when ')'
           scores['(']
         when ']'
           scores['[']
         when '}'
           scores['{']
         when '>'
           scores['<']
         end
end

p sum
