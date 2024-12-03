require_relative 'report'

input = File.read('input.txt')

reports = input.split("\n").map { |line| line.split(/\s+/) }

safe_levels = reports.reduce(0) do |acc, report|
  rep = report.map(&:to_i)
  Report.new(rep).safe? ? acc + 1 : acc
end

puts "Safe levels: #{safe_levels}"
