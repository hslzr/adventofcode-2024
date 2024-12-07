class GuardLog
  attr_accessor :trace, :turns

  def initialize()
    @trace = Hash.new(0)
    @turns = {}
  end

  def record(position)
    @trace[position] += 1
  end

  def record_turn(position, direction)
    @turns[position] = direction
  end

  def in_trace?(position)
    @trace[position] > 0
  end
end
