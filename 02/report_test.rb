require "minitest/autorun"
require_relative "report"

class ReportTest < Minitest::Test
  def test_when_levels_are_safe
    levels = [1, 2, 3, 4, 5]
    report = Report.new(levels)

    assert report.safe?
  end

  def test_when_levels_are_unsafe
    # Unsteady variation
    levels = [1, 2, 3, 7, 8]
    report = Report.new(levels)

    refute report.safe?
  end

  def test_with_steady_variation
    # Steady variation, but not all increasing or decreasing
    levels = [1, 2, 3, 2, 1]
    report = Report.new(levels)

    refute report.safe?
  end

  def test_when_all_increasing
    levels = [1, 2, 3, 4, 5]
    report = Report.new(levels)

    assert report.safe?
  end

  def test_dampening_with_one_bad_level
    levels = [1, 2, 3, 4, 9]
    report = Report.new(levels)

    assert report.safe?

    levels = [5, 1, 3, 4, 5]
    report = Report.new(levels)

    assert report.safe?
  end

  def test_dampening_with_two_bad_levels
    levels = [1, 2, 3, 9, 9]
    report = Report.new(levels)

    refute report.safe?
  end
end
