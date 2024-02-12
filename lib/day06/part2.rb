class Day06p2
  class << self
    def call
      file = File.read('lib/day06/input1.txt')
      process(file)
    end

    def process(input)
      games = {}
      timing, distance = input.strip.split("\n").map { |line| line.split(':').last.gsub(' ', '').to_i }
      number_of_ways = 0

      min_accel_time = find_minimal_accel_for(timing, distance)
      max_accel_time = timing

      (min_accel_time...max_accel_time).each do |accel_time|
        distance_with_accel = (timing - accel_time) * accel_time
        number_of_ways += 1 if distance_with_accel > distance
      end
      number_of_ways
    end

    def find_minimal_accel_for(timing, distance)
      ((distance / timing)..timing).find { |accel| ((timing - accel) * accel) > distance }
    end
  end
end

class Test < Minitest::Test
  def test_day6_part2
    assert_data = <<~DATA
      Time:      7  15   30
      Distance:  9  40  200
    DATA

    assert_equal 71503, Day06p2.process(assert_data)
  end
end
