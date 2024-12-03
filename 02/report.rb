class Report
  attr_reader :levels

  def initialize(levels)
    @levels = levels
  end

  def safe?
    valid = steady_variation? && (all_increasing? || all_decreasing?)

    valid ? true : solved_by_dampener?
  end

  def solved_by_dampener?
    levels.length.times do |index|
      copy = levels.dup
      copy.delete_at(index)

      if (all_increasing?(copy) || all_decreasing?(copy)) && steady_variation?(copy)
        # Tests are nice but I like to see the output
        # puts "Dampened: #{levels} -> #{copy} (removing index ##{index}: #{levels[index]})"
        return true
      end
    end

    false
  end

  private

  def all_increasing?(levels = self.levels)
    levels.each_cons(2).all? { |a, b| a < b }
  end

  def all_decreasing?(levels = self.levels)
    levels.each_cons(2).all? { |a, b| a > b }
  end

  def steady_variation?(levels = self.levels)
    levels.each_cons(2).all? { |a, b| (1..3) === (a - b).abs }
  end
end
