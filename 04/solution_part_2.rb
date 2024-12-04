class Input
  attr_reader :lines
  def initialize(raw_input)
    @raw_input = raw_input
    @lines = raw_input.lines.map(&:chomp)
  end
end

def is_x_mas?(input, x, y)
  return false unless input.lines[x][y] == ?A

  [
    top_left_m?(input, x, y),
    top_right_m?(input, x, y),
    bottom_left_m?(input, x, y),
    bottom_right_m?(input, x, y)
  ].select { _1 }.size == 2
end

def top_left_m?(input, x, y)
  input.lines[x-1][y-1] == ?M && input.lines[x+1][y+1] == ?S
end

def top_right_m?(input, x, y)
  input.lines[x+1][y-1] == ?M && input.lines[x-1][y+1] == ?S
end

def bottom_left_m?(input, x, y)
  input.lines[x-1][y+1] == ?M && input.lines[x+1][y-1] == ?S
end

def bottom_right_m?(input, x, y)
  input.lines[x+1][y+1] == ?M && input.lines[x-1][y-1] == ?S
end

input = Input.new(File.read('input.txt'))

horizontal_size = input.lines.first.size
vertical_size = input.lines.size


# Simple diagram do better understand
#  (x-1, y-1)  (x, y-1)  (x+1, y-1)
#  (x-1, y)       A      (x+1, y)
#  (x-1, y+1)  (x, y+1)  (x+1, y+1)
#

x_mas_count = 0

(1...(horizontal_size - 1)).each do |x|
  (1...(vertical_size - 1)).each do |y|
    next unless input.lines[x][y] == ?A

    x_mas_count += 1 if is_x_mas?(input, x, y)
  end
end

puts x_mas_count
