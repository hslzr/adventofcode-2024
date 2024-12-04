require "debug"

class Input
  attr_reader :lines
  def initialize(raw_input)
    @raw_input = raw_input
    @lines = raw_input.lines.map(&:chomp)
  end
end

input = Input.new(File.read('input.txt'))

horizontal_size = input.lines.first.size
vertical_size = input.lines.size

XMAS = "XMAS"
SAMX = "SAMX"

pattern_count = 0

# Horizontal XMAS and SMAX
input.lines.map do |line|
  xmas_found = line.scan(XMAS).count
  pattern_count += xmas_found
  smax_found = line.scan(SAMX).count
  pattern_count += smax_found

  #puts "#{line} - xmas: #{xmas_found},  samx: #{smax_found}"
end

# Vertical XMAS and SMAX
vertical_size.times do |i|
  vertical_line = input.lines.map { |line| line[i] }.join
  pattern_count += vertical_line.scan(XMAS).count
  pattern_count += vertical_line.scan(SAMX).count

  #puts "#{vertical_line} - xmas: #{vertical_line.scan(XMAS).count},  samx: #{vertical_line.scan(SAMX).count}"
end

# Get the diagonal lines
diagonal_lines = []

# Bottom left to top right
vertical_size.times do |i|
  diagonal_line = ""
  x = 0
  y = i
  while y >= 0
    diagonal_line += input.lines[y][x]
    x += 1
    y -= 1
  end
  diagonal_lines << diagonal_line
end

(horizontal_size - 1).times do |i|
  diagonal_line = ""
  x = i + 1
  y = vertical_size - 1
  while x < horizontal_size
    diagonal_line += input.lines[y][x]
    x += 1
    y -= 1
  end
  diagonal_lines << diagonal_line
end

# Top left to bottom right
horizontal_size.times do |i|
  diagonal_line = ""
  x = i
  y = 0
  while x < horizontal_size
    diagonal_line += input.lines[y][x]
    x += 1
    y += 1
  end
  diagonal_lines << diagonal_line
end

(vertical_size - 1).times do |i|
  diagonal_line = ""
  x = 0
  y = i + 1
  while y < vertical_size
    diagonal_line += input.lines[y][x]
    x += 1
    y += 1
  end
  diagonal_lines << diagonal_line
end

diagonal_lines.each do |line|
  pattern_count += line.scan(XMAS).count
  pattern_count += line.scan(SAMX).count
end

puts pattern_count
