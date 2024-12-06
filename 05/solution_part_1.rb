require_relative "update"

input = File.read("input.txt").split("\n")

rules = {}
updates = []

input.each do |line|
  if md = line.match(/(?<num>\d+)\|(?<rule>\d+)/)
    rules[md[:num]] ||= []
    rules[md[:num]] << md[:rule]
    rules[md[:num]].sort!
  else
    next if line.empty?
    updates << Update.new(line.split(","))
  end
end

updates.each do |update|
  update.instructions.each_with_index do |instruction, index|
    next unless rules[instruction]
    
    previous_instructions = update.instructions[0..index]

    if previous_instructions.intersect?(rules[instruction])
      update.right_order = false
      break
    end
  end
end

puts "Total updates: #{updates.length}"
puts "Updates in right order: #{updates.select(&:right_order?).length}"
puts "Total sum of their middle_pages: #{updates.select(&:right_order?).sum(&:middle_page)}"
