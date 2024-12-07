require_relative "map"
require_relative "guard"
require_relative "guard_log"

map = Map.new(File.read('input.txt').split("\n").map { |line| line.split('') })
guard = Guard.new(
  position: map.current_guard_position,
  direction: map.current_guard_direction,
  map: map,
  log: GuardLog.new
)

while guard.in_bounds?
  guard.advance
end
