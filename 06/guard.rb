class Guard
  attr_reader :position, :direction, :map, :positions_visited, :log

  def initialize(position:, direction:, map:, log: nil)
    @position = position
    @direction = direction
    @map = map
    @positions_visited = 0
    @log = log
    
    puts "Guard initialized at #{position} facing #{direction}"
  end

  def advance
    log.record(position) if log

    previous_position = position.dup
    @position = next_position

    @map.set_tile(*previous_position, ?X)

    turn_right if map.obstacle?(*next_position)

    @positions_visited += 1 unless map.visited?(*position)
    
    if !map.out_of_bounds?(*position)
      @map.set_tile(*position, avatar)
    else
      @map.set_tile(*previous_position, ?X)
    end
  end

  def turn_right
    @direction = case @direction
                 when :up then :right
                 when :right then :down
                 when :down then :left
                 when :left then :up
                 end
    log.record_turn(@position, @direction) if log
  end

  def next_position
    case @direction
    when :up then [@position[0], @position[1] - 1]
    when :right then [@position[0] + 1, @position[1]]
    when :down then [@position[0], @position[1] + 1]
    when :left then [@position[0] - 1, @position[1]]
    end
  end

  def avatar
    case @direction
    when :up then ?^
    when :right then ?>
    when :down then ?v
    when :left then ?<
    end
  end

  def in_bounds?
    position[0] < map.layout.first.size && position[1] < map.layout.size
  end

end
