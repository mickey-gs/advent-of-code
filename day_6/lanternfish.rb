data = File.open('data.txt', 'r').readlines.map { |line| line.split(',') }
data = data.flatten.map(&:to_i)

days = 80
days.times do
  new_fish = 0
  data = data.map do |num|
    if num.zero?
      new_fish += 1
      6
    else
      num - 1
    end
  end
  new_fish.times { data << 8 }
end

p data.length
