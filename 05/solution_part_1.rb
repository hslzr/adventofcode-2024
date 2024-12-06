require "debug"
require_relative "update"

input = File.read("test_input.txt").split("\n")

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
    
    previous_instructions = update.instructions[0...index]

    if previous_instructions.intersect?(rules[instruction])
      update.right_order = false
      update.broken_rule = "#{instruction}|#{previous_instructions[-1]}"
      break
    end
  end
end

wrong_updates = updates.select { |update| !update.right_order? }

wrong_updates.each do |update|
  puts "Fixing [#{update.instructions.join(", ")}]"
  while !update.right_order?
    if update.broken_rule
      puts "Fixing rule: #{update.broken_rule}"
      rule, offending_instruction = update.broken_rule.split("|")
      
      # Shift the offending instruction to the right place
      removed = update.instructions.delete(offending_instruction)
      update.instructions.insert(update.instructions.index(rule) + 2, removed)
      update.instructions.compact!
    end

    # Check if the order is correct now
    # TODO: TRAVERSE THE ARRAY IN REVERSE
    fixed = update.instructions.cycle.each_with_index.map do |instruction, index|
      next unless rules[instruction]
      actual_index = update.instructions.index(instruction)
      puts "Checking #{instruction} against #{update.instructions[0...actual_index].join(", ")}"

      previous_instructions = update.instructions[0...actual_index]

      if !previous_instructions.intersect?(rules[instruction])
        update.right_order = true
        update.broken_rule = nil
        is_correct = true
      else
        is_correct = false
        update.right_order = false
        update.broken_rule = "#{instruction}|#{previous_instructions[-1]}"
      end

      is_correct
    end.all?

    break if fixed
  end
end 

debugger
