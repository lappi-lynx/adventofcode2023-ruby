class Day04p2
  class << self
    def call
      file = File.open('lib/day04/input1.txt', 'r')
      process(file)
    end

    def process(input)
      card_mapping = Hash.new { |h, k| h[k] = 1 }

      input.each_line do |card|
        card.split => _, id, *numbers
        game_id    = id.to_i
        points     = points_from_the_game(numbers)

        if points.positive?
          card_mapping[game_id].times do
            points.times do |idx|
              card_mapping[game_id + idx + 1] += 1
            end
          end
        else
          card_mapping[game_id]
        end
      end
      card_mapping.values.sum
    end

    def points_from_the_game(numbers)
      numbers => *winning_numbers, "|", *given_numbers

      (given_numbers & winning_numbers).size
    end
  end
end

class Test < Minitest::Test
  def test_day4_part2
    assert_data = <<~DATA
      Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
      Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
      Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
      Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
      Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
      Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11
    DATA

    assert_equal 30, Day04p2.process(assert_data)
  end
end
