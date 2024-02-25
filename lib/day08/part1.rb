class Day08
  class << self
    def call
      file = File.read('lib/day08/input1.txt')
      process(file)
    end

    def process(input)
      input.strip.split("\n") => directions, "", *puzzle
      puzzles_collection = puzzle.each_with_object({}) do |puzz, h| 
        puzz.gsub(/\W/, ' ').split => k, l, r 
        h[k] = {"L" => l, "R" => r}
      end

      find_endpoint_for(puzzles_collection, directions)
    end

    def find_endpoint_for(input, directions)
      steps = 0      
      start_point = "AAA"
      end_point   = "ZZZ"
      next_step   = start_point
      while next_step != end_point
        direction = directions[steps % directions.length]
        next_step = input[next_step][direction]
        steps += 1
      end

      steps
    end
  end
end

class Test < Minitest::Test
  def test_day8_part1
    assert_data = <<~DATA
      LLR

      AAA = (BBB, BBB)
      BBB = (AAA, ZZZ)
      ZZZ = (ZZZ, ZZZ)
    DATA

    assert_equal 6, Day08.process(assert_data)
  end
end
