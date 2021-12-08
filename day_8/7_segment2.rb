data = File.open('data.txt', 'r').readlines.map(&:chomp)
data = data.map do |line|
  line.split('|').map { |half| half.split(' ') }
end

def unique_segments(signal_patterns)
  segments = {}
  segments[:one] = []
  segments[:four] = []
  segments[:seven] = []
  segments[:eight] = []
  signal_patterns.each do |pattern|
    key = case pattern.length
          when 2
            :one
          when 3
            :seven
          when 4
            :four
          when 7
            :eight
          else
            :none
          end
    pattern.split('').each { |ch| segments[key] << ch } unless key == :none
  end

  segments
end

def sixes_zeroes_nines(signal_patterns, segments)
  signals = []
  signal_patterns.each.with_index do |pattern, i|
    case pattern.length
    when 2
      signals[i] = 1
    when 3
      signals[i] = 7
    when 4
      signals[i] = 4
    when 7
      signals[i] = 8
    when 6
      zero_or_nine = true
      segments[:one].each do |segment|
        zero_or_nine = false unless pattern.include? segment
      end
      if zero_or_nine
        is_nine = true
        segments[:four].each do |segment|
          is_nine = false unless pattern.include? segment
        end
        if is_nine
          signals[i] = 9
          segments[:nine] = []
          pattern.split('').each { |ch| segments[:nine] << ch }
        else
          signals[i] = 0
          segments[:zero] = []
          pattern.split('').each { |ch| segments[:zero] << ch }
        end
      else
        signals[i] = 6
        segments[:six] = []
        pattern.split('').each { |ch| segments[:six] << ch }
      end
    else
      signals[i] = -1
    end
  end

  return signals, segments
end

def complete_signal(signals, all_patterns, segments)
  signals = signals.map.with_index do |signal, i|
    if signal == -1
      case all_patterns[i].length
      when 2
        1
      when 3
        7
      when 4
        4
      when 7
        8
      when 5
        is_three = true
        segments[:one].each do |segment|
          is_three = false unless all_patterns[i].include? segment
        end
        if is_three
          3
        else
          is_five = true
          all_patterns[i].split('').each do |segment|
            is_five = false unless segments[:six].include? segment
          end
          is_five ? 5 : 2
        end
      when 6
        if (segments[:six] - all_patterns[i].split('')).empty?
          6
        elsif (segments[:nine] - all_patterns[i].split('')).empty?
          9
        else
          0
        end
      else
        all_patterns[i] = -1
      end
    else
      signal
    end
  end

  signals
end

# if it contains all of 7 and 4 and one more signal, it must be 9
# if it contains 6 segments:
#   if the segment it's missing is part of 1, it must be 6
#   or else it's 0

signals = []
total = data.reduce(0) do |sum, line|
  segments = unique_segments(line[0])

  signals, segments = sixes_zeroes_nines(line[0], segments)

  (0..3).each do |i|
    signals[line[0].length + i] = -1
  end

  all_patterns = (line[0] << line[1]).flatten
  
  sum + complete_signal(signals, all_patterns, segments)[-4..-1].join.to_i
end

p total 
