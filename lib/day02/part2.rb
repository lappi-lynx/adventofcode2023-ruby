class Day02p2
  class << self
    def call
      file = File.open('lib/day02/input1.txt', 'r')
      process(file)
    end

    def process(input)
    end
  end
end

class Test < Minitest::Test
  def test_day2_part2
    assert_data = <<~DATA
    DATA

    # assert_equal 281, Day02p2.process(assert_data)
  end
end
