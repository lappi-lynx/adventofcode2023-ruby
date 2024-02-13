# To make things a little more interesting, the Elf introduces one additional rule. Now, J cards are jokers - wildcards that can act like whatever card would make the hand the strongest type possible.

# To balance this, J cards are now the weakest individual cards, weaker even than 2. The other cards stay in the same order: A, K, Q, T, 9, 8, 7, 6, 5, 4, 3, 2, J.

# J cards can pretend to be whatever card is best for the purpose of determining hand type; for example, QJJQ2 is now considered four of a kind. However, for the purpose of breaking ties between two hands of the same type, J is always treated as J, not the card it's pretending to be: JKKK2 is weaker than QQQQ2 because J is weaker than Q.

class Handp2
  include Comparable

  PRIORITY_LIST = %w(
    A K Q T 9 8 7 6 5 4 3 2 J
  ).reverse.freeze

  TYPES_MAPPING = {
    high_card: 1,
    one_pair: 2,
    two_pairs: 3,
    three_of_kind: 4,
    full_house: 5,
    four_of_kind: 6,
    five_of_kind: 7
  }.freeze

  attr_reader :combination, :bid

  def initialize(combination, bid)
    @combination = combination
    @bid = bid.to_i
  end

  def compare_high_card(c1, c2)
    chars1 = c1.chars
    chars2 = c2.chars

    chars1.zip(chars2).each do |char1, char2|
      comparison_result = PRIORITY_LIST.index(char1) <=> PRIORITY_LIST.index(char2)

      return comparison_result if comparison_result != 0
    end

    0
  end

  def <=>(other)
    c1_type = get_combination_type(combination)
    c2_type = get_combination_type(other.combination)

    if c1_type == c2_type
      compare_high_card(combination, other.combination)
    else
      TYPES_MAPPING[c1_type] <=> TYPES_MAPPING[c2_type]
    end
  end

  def get_combination_type(combination)
    combination_boost = combination.chars.tally['J']
    combination_type = case combination.chars.tally.values.sort.reverse
    when [5] then :five_of_kind
    when [4, 1] then :four_of_kind
    when [3, 2] then :full_house
    when [3, 1, 1] then :three_of_kind
    when [2, 2, 1] then :two_pairs
    when [2, 1, 1, 1] then :one_pair
    else :high_card
    end

    if combination_boost.nil? || (combination_type == :five_of_kind)
      combination_type
    else
      case combination_type
      when :four_of_kind
        :five_of_kind
      when :full_house
        :five_of_kind
      when :three_of_kind
        :four_of_kind
      when :two_pairs
        (combination_boost == 2) ? :four_of_kind : :full_house
      when :one_pair
        :three_of_kind
      else
        :one_pair
      end
    end
  end
end

class Day07p2
  class << self
    def call
      file = File.read('lib/day07/input1.txt')
      process(file)
    end

    def process(input)
      input = input.split("\n")

      all_hands = input.map do |hand|
        combination, bid = hand.split
        Handp2.new(combination, bid)
      end.sort

      all_hands.each_with_index.sum do |hand, index|
        hand.bid * (index + 1)
      end
    end
  end
end

class Test < Minitest::Test
  def test_day7_part2
    assert_data = <<~DATA
      32T3K 765
      T55J5 684
      KK677 28
      KTJJT 220
      QQQJA 483
    DATA

    assert_equal 5905, Day07p2.process(assert_data)
  end
end
