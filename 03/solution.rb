input = File.read('input.txt')

valid_instructions = input.scan(/mul\(\d{1,3},\d{1,3}\)/)

total = valid_instructions.reduce(0) do |acc, instruction|
  md = instruction.match(/(?<num_1>\d{1,3}),(?<num_2>\d{1,3})/)
  acc + (md[:num_1].to_i * md[:num_2].to_i)
end

puts "Total: #{total}"
