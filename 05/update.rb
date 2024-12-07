class Update
  attr_accessor :right_order, :broken_rule, :instructions

  def initialize(instructions)
    @instructions = Array(instructions)
    @right_order = true
    @broken_rule = nil
  end

  def right_order?
    @right_order
  end

  def middle_page
    instructions[instructions.length / 2].to_i
  end

  def find_broken_rule(rules)
    broken_rule = instructions.detect do |instruction|
      rules[instruction] && rules[instruction].any? do |rule|
        previous_instructions = instructions[0...instructions.index(instruction)]

        if previous_instructions.intersect?(rules[instruction])
          @broken_rule = "#{instruction}|#{previous_instructions[-1]}"
          true
        end
      end
    end

    @right_order = broken_rule.nil?
  end

  def fix!
    return if broken_rule.nil?

    rule, bad_instruction = broken_rule.split("|")

    rule_index = instructions.index(rule)
    bad_instruction_index = instructions.index(bad_instruction)

    instructions[rule_index], instructions[bad_instruction_index] = instructions[bad_instruction_index], instructions[rule_index]
    broken_rule = nil
  end
end
