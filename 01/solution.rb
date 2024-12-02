# Solution for Advent of Code 2024
# https://adventofcode.com/2024/day/1

# Read the input file
input = File.read("input.txt")

list_left, list_right = [], []

# Part 1
input.split("\n").each do |line|
  numbers = line.split(/\s+/).map(&:to_i)
  list_left << numbers[0]
  list_right << numbers[1]
end

list_left.sort!
list_right.sort!

total_sum = 0

list_left.each.with_index do |num_1, index|
  total_sum += (num_1 - list_right[index]).abs
end

puts "Part 1: #{total_sum}"

# Part 2
right_tally = list_right.tally

similarity_score = list_left.reduce(0) do |acc, num|
  sim_score = right_tally.fetch(num, 0)

  acc + (num * sim_score)
end

puts "Part 2: #{similarity_score}"
