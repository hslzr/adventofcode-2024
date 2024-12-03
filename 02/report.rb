class Report
  attr_reader :levels

  def initialize(levels)
    @levels = levels
  end

  def safe?
    return false unless steady_variation?
    return false unless (all_increasing? || all_decreasing?)

    true
  end

  def unsafe?
    !safe?
  end

  private

  def all_increasing?
    levels.each_cons(2).all? { |a, b| a < b }
  end

  def all_decreasing?
    levels.each_cons(2).all? { |a, b| a > b }
  end

  def steady_variation?
    levels.each_cons(2).all? { |a, b| (1..3) === (a - b).abs }
  end
end
