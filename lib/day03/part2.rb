class Day03p2
  AROUND_THE_POINT = [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]].freeze

  class << self
    def call
      file = File.open('lib/day03/input1.txt', 'r')
      process(file)
    end

    def process(input)
      data = input.each_line.map(&:chomp)
      result = 0

      symbol_coords = Set.new

      data.each_with_index do |line, x|
        line.chars.each_with_index do |char, y|
          symbol_coords << [x, y] if char == '*'
        end
      end

      symbol_coords.each_with_index do |(x, y), i|
        number_coords = Set.new

        AROUND_THE_POINT.each do |dx, dy|
          shifted_x, shifted_y = (x + dx), (y + dy)

          if (data[shifted_x][shifted_y] =~ /\d/)
            while data[shifted_x][shifted_y - 1] =~ /\d/
              shifted_y -= 1
            end
            number_coords << [shifted_x, shifted_y]
          end
        end

        if number_coords.size == 2
          result += number_coords.map do |x, y|
            data[x][y..].to_i
          end.inject(:*)
        end
      end

      result
    end
  end
end

class Test < Minitest::Test
  def test_day3_part2
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

    assert_equal 467835, Day03p2.process(assert_data)
  end
end
