class StringConsumer
  attr_reader :input, :enabled_instructions

  MUL_SYNTAX = /mul\(\d{1,3},\d{1,3}\)/
  DO_FLAG = /do\(\)/
  DONT_FLAG = /don't\(\)/
  COMMAND = /#{MUL_SYNTAX}|#{DO_FLAG}|#{DONT_FLAG}/

  MUL_DIGITS = /mul\((?<num_1>\d{1,3}),(?<num_2>\d{1,3})\)/

  def self.process(input)
    consumer = new(input)
    consumer.consume
    
    consumer.enabled_instructions.reduce(0) do |acc, instruction|
      acc + consumer.mul_instruction(instruction)
    end
  end

  def initialize(input)
    @input = input
    @enabled = true
    @enabled_instructions = []
  end

  def consume
    while instruction = @input.slice!(COMMAND)
      case instruction
      when MUL_SYNTAX
        next unless @enabled

        @enabled_instructions << instruction
      when DO_FLAG
        next if @enabled

        @enabled = true
      when DONT_FLAG
        next unless @enabled

        @enabled = false
      end
    end
  end

  def mul_instruction(instruction)
    md = instruction.match(MUL_DIGITS)
    md[:num_1].to_i * md[:num_2].to_i
  end
end
