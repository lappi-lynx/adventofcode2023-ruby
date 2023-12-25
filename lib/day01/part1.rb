require 'minitest/autorun'
require 'pry'

# The newly-improved calibration document consists of lines of text; each line originally contained a specific calibration value that the Elves now need to recover. On each line, the calibration value can be found by combining the first digit and the last digit (in that order) to form a single two-digit number.

# For example:

# 1abc2
# pqr3stu8vwx
# a1b2c3d4e5f
# treb7uchet
# In this example, the calibration values of these four lines are 12, 38, 15, and 77. Adding these together produces 142.

# Consider your entire calibration document. What is the sum of all of the calibration values?

class Day01
  class << self
    def call
      file = File.open('lib/day01/input1.txt', 'r')
      process(file)
    end

    def process(input)
      memo = 0

      input.each_line do |line|
        digits = line.scan(/\d/)
        next if digits.size == 0

        if digits.size == 1
          memo += (digits[0] + digits[0]).to_i
        else
          memo += (digits[0] + digits[-1]).to_i
        end
      end
      memo
    end
  end
end

class Test < Minitest::Test
  def test_part1
    assert_data = <<~DATA
      1abc2
      pqr3stu8vwx
      a1b2c3d4e5f
      treb7uchet
    DATA

    assert_equal 142, Day01.process(assert_data)
  end
end
