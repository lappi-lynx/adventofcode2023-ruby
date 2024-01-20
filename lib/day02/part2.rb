class Day02p2
  COLORS = %w(red green blue)

  class << self
    def call
      file = File.open('lib/day02/input1.txt', 'r')
      process(file)
    end

    def process(input)
      matched_ids_sum = 0
      input.each_line do |line|
        match_data = line.match(/Game (\d+): (.+)/)
        game_id    = match_data[1]
        games_info = match_data[2].split('; ')
        memoized_games = Hash[COLORS.product([0])]

        games_info.each do |game|
          game.split(', ').each do |cube|
            value, color = cube.split
            memoized_games[color] = value.to_i if memoized_games[color] && memoized_games[color] < value.to_i
          end
        end
        matched_ids_sum += memoized_games.values.inject(:*)
      end
      matched_ids_sum
    end
  end
end

class Test < Minitest::Test
  def test_day2_part2
    assert_data = <<~DATA
      Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
      Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
      Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
      Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
      Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
    DATA

    assert_equal 2286, Day02p2.process(assert_data)
  end
end
