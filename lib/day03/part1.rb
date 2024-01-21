# engine part seems to be missing from the engine, but nobody can figure out which one. If you can add up all the part numbers in the engine schematic, it should be easy to work out which part is missing.

# The engine schematic (your puzzle input) consists of a visual representation of the engine. There are lots of numbers and symbols you don't really understand, but apparently any number adjacent to a symbol, even diagonally, is a "part number" and should be included in your sum. (Periods (.) do not count as a symbol.)

# In this schematic, two numbers are not part numbers because they are not adjacent to a symbol: 114 (top right) and 58 (middle right). Every other number is adjacent to a symbol and so is a part number; their sum is 4361.

# Of course, the actual engine schematic is much larger. What is the sum of all of the part numbers in the engine schematic?

class Day03
  AROUND_THE_POINT = [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]].freeze

  class << self
    def call
      file = File.open('lib/day03/input1.txt', 'r')
      process(file)
    end

    def process(input)
      data = input.each_line.map(&:chomp)

      symbol_coords = Set.new

      data.each_with_index do |line, x|
        line.chars.each_with_index do |char, y|
          symbol_coords << [x, y] if char =~ /[^\d\.]/
        end
      end

      number_coords = Set.new

      symbol_coords.each do |x, y|
        AROUND_THE_POINT.each do |dx, dy|

          number_coords << [x + dx, y + dy] if (data[x + dx][y + dy] =~ /\d/)
        end
      end

      number_start_coords = Set.new

      number_coords.each do |x, y|
        # find start position of each number
        while data[x][y-1] =~ /\d/
          y -= 1
        end
        number_start_coords << [x, y]
      end
      number_start_coords.sum { |x, y| data[x][y..].to_i }
    end
  end
end

class Test < Minitest::Test
  def test_day3_part1
    assert_data = <<~DATA
      467..114..
      ...*......
      ..35..633.
      ......#...
      617*......
      .....+.58.
      ..592.....
      ......755.
      ...$.*....
      .664.598..
    DATA

    assert_equal 4361, Day03.process(assert_data)
  end
end
