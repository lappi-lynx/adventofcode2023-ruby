class Day01p2
  SPELLED_NUMBERS = %w(
    one
    two
    three
    four
    five
    six
    seven
    eight
    nine
  ).freeze

  class << self
    def call
      file = File.open('lib/day01/input1.txt', 'r')
      process(file)
    end

    def process(input)
      memo = 0

      input.each_line do |line|
        parsed_digits = []
        line.chars.each_with_index do |char, index|
          parsed_digits << char if (char =~ /\d/)

          SPELLED_NUMBERS.each_with_index do |word, i|
            parsed_digits << String(i+1) if line[index, word.length] == word
          end
        end
        memo += (parsed_digits[0] + parsed_digits[-1]).to_i
      end
      memo
    end
  end
end

class Test < Minitest::Test
  def test_day1_part2
    assert_data = <<~DATA
      two1nine
      eightwothree
      abcone2threexyz
      xtwone3four
      4nineeightseven2
      zoneight234
      7pqrstsixteen
    DATA

    assert_equal 281, Day01p2.process(assert_data)
  end
end
