data = File.open('data.txt', 'r').readlines.map { |line| line.chomp.split('').map(&:to_i) }

flashes = 0
100.times do

  data = data.map { |line| line.map { |octo| octo + 1 } }
  loop do
    finished = true
    data.each.with_index do |line, i|
      line.each.with_index do |octo, j|
        next if octo < 10

        finished = false
        flashes += 1

        line[j - 1] += 1 unless (j - 1).negative? || line[j - 1].zero?
        line[j + 1] += 1 unless line[j + 1].nil? || line[j + 1].zero?

        unless (i - 1).negative?
          data[i - 1][j - 1] += 1 unless (j - 1).negative? || data[i - 1][j - 1].zero?
          data[i - 1][j] += 1 unless data[i - 1][j].zero?
          data[i - 1][j + 1] += 1 unless data[i - 1][j + 1].nil? || data[i - 1][j + 1].zero?
        end
        unless data[i + 1].nil?
          data[i + 1][j - 1] += 1 unless (j - 1).negative? || data[i + 1][j - 1].zero?
          data[i + 1][j] += 1 unless data[i + 1][j].zero?
          data[i + 1][j + 1] += 1 unless data[i - 1][j + 1].nil? || data[i + 1][j + 1].zero?
        end

        data[i][j] = 0
      end
    end

    break if finished
  end
end

p flashes
