class Day01p2
  NUMBERS_MAPPING = {
    'one' => '1',
    'two' => '2',
    'three' => '3',
    'four' => '4',
    'five' => '5',
    'six' => '6',
    'seven' => '7',
    'eight' => '8',
    'nine' => '9'
  }.freeze

  class << self
    def call
      file = File.open('lib/day01/input1.txt', 'r')
      process(file)
    end

    def process(input)
      memo = 0
      regex = /\d|one|two|three|four|five|six|seven|eight|nine/

      input.each_line do |line|
        first_digit = get_number_from(line.scan(regex)&.first)
        last_digit  = get_number_from(line.scan(regex)&.last)
        next if (first_digit.nil? || last_digit.nil?)

        memo += (first_digit + last_digit).to_i
      end
      memo
    end

    def get_number_from(str)
      str[/\d/] || NUMBERS_MAPPING[str]
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
