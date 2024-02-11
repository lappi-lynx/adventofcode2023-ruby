

class Day06
  class << self
    def call
      file = File.read('lib/day06/input1.txt')
      process(file)
    end

    def process(input)
      games = {}
      timings, distances = input.strip.split("\n").map { |line| line.split(':').last.split }
      number_of_ways = Array.new(timings.size, 0)
      timings.size.times do |idx|
        games[idx] = [timings[idx].to_i, distances[idx].to_i]
      end

      games.each do |idx, (timing, distance)|
        min_accel_time = find_minimal_accel_for(timing, distance)
        max_accel_time = timing

        (min_accel_time...max_accel_time).each do |accel_time|
          distance_with_accel = (timing - accel_time) * accel_time
          number_of_ways[idx] += 1 if distance_with_accel > distance
        end
      end
      number_of_ways.inject(&:*)
    end

    def find_minimal_accel_for(timing, distance)
      ((distance / timing)..timing).find { |accel| ((timing - accel) * accel) > distance }
    end
  end
end

class Test < Minitest::Test
  def test_day6_part1
    assert_data = <<~DATA
      Time:      7  15   30
      Distance:  9  40  200
    DATA

    assert_equal 288, Day06.process(assert_data)
  end
end
