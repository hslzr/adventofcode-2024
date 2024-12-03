input = File.read('input.txt')

# Part 1
valid_instructions = input.scan(/mul\(\d{1,3},\d{1,3}\)/)

total = valid_instructions.reduce(0) do |acc, instruction|
  md = instruction.match(/(?<num_1>\d{1,3}),(?<num_2>\d{1,3})/)
  acc + (md[:num_1].to_i * md[:num_2].to_i)
end

puts "Total Part 1: #{total}"

# Part 2
require_relative "string_consumer"

total = StringConsumer.process(input)

puts "Total Part 2: #{total}"
