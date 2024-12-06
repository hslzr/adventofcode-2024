class Update
  attr_accessor :right_order, :broken_rule, :instructions, :middle_page

  def initialize(instructions)
    @instructions = Array(instructions)
    @right_order = true
    @middle_page = get_middle_page
    @broken_rule = nil
  end

  def right_order?
    @right_order
  end

  def get_middle_page
    instructions[instructions.length / 2].to_i
  end
end
