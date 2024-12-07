require_relative "map"
require_relative "guard"

map = Map.new(File.read('input.txt').split("\n").map { |line| line.split('') })
guard = Guard.new(position: map.current_guard_position, direction: map.current_guard_direction, map: map)

while guard.in_bounds?
  guard.advance
end

puts "Guard visited #{guard.positions_visited} unique positions."

