class Day08p2
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
      starting_nodes = input.keys.select { |node| node.end_with?('A') }
      current_nodes = starting_nodes

      steps_collection = []

      current_nodes.each do |node|
        steps = 0
        while !node.end_with? 'Z'
          direction = directions[steps % directions.length]
          node = input[node][direction]
          steps += 1
        end
        steps_collection << steps
      end

      steps_collection.inject(&:lcm)
    end
  end
end

class Test < Minitest::Test
  def test_day8_part2
    assert_data = <<~DATA
      LR

      11A = (11B, XXX)
      11B = (XXX, 11Z)
      11Z = (11B, XXX)
      22A = (22B, XXX)
      22B = (22C, 22C)
      22C = (22Z, 22Z)
      22Z = (22B, 22B)
      XXX = (XXX, XXX)
    DATA

    assert_equal 6, Day08p2.process(assert_data)
  end
end
