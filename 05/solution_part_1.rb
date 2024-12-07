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
  puts "------------------------------------"
  puts "Broken rule: #{update.broken_rule}"
  puts "Instructions: #{update.instructions.join(",")}"

  while !update.right_order?
    update.fix!
    update.find_broken_rule(rules)
  end

  puts "Fixed instructions: #{update.instructions.join(",")}"
end 

puts wrong_updates.select(&:right_order?).sum(&:middle_page)

