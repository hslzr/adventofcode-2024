class Update
  attr_reader :instructions, :middle_page
  attr_accessor :right_order

  def initialize(instructions)
    @instructions = Array(instructions)
    @right_order = true
    @middle_page ||= get_middle_page
  end

  def right_order?
    @right_order
  end

  def get_middle_page
    instructions[instructions.length / 2].to_i
  end
end
