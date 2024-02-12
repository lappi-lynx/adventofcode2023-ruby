# In Camel Cards, you get a list of hands, and your goal is to order them based on the strength of each hand. A hand consists of five cards labeled one of A, K, Q, J, T, 9, 8, 7, 6, 5, 4, 3, or 2. The relative strength of each card follows this order, where A is the highest and 2 is the lowest.

# Every hand is exactly one type. From strongest to weakest, they are:

# Five of a kind, where all five cards have the same label: AAAAA
# Four of a kind, where four cards have the same label and one card has a different label: AA8AA
# Full house, where three cards have the same label, and the remaining two cards share a different label: 23332
# Three of a kind, where three cards have the same label, and the remaining two cards are each different from any other card in the hand: TTT98
# Two pair, where two cards share one label, two other cards share a second label, and the remaining card has a third label: 23432
# One pair, where two cards share one label, and the other three cards have a different label from the pair and each other: A23A4
# High card, where all cards' labels are distinct: 23456
# Hands are primarily ordered based on type; for example, every full house is stronger than any three of a kind.

# If two hands have the same type, a second ordering rule takes effect. Start by comparing the first card in each hand. If these cards are different, the hand with the stronger first card is considered stronger. If the first card in each hand have the same label, however, then move on to considering the second card in each hand. If they differ, the hand with the higher second card wins; otherwise, continue with the third card in each hand, then the fourth, then the fifth.

# So, 33332 and 2AAAA are both four of a kind hands, but 33332 is stronger because its first card is stronger. Similarly, 77888 and 77788 are both a full house, but 77888 is stronger because its third card is stronger (and both hands have the same first and second card).

class Hand
  include Comparable

  PRIORITY_LIST = %w(
    A K Q J T 9 8 7 6 5 4 3 2
  ).reverse.freeze

  TYPES_MAPPING = {
    five_of_kind: 7,
    four_of_kind: 6,
    full_house: 5,
    three_of_kind: 4,
    two_pairs: 3,
    one_pair: 2,
    high_card: 1
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
    case combination.chars.tally.values.sort.reverse
    when [5] then :five_of_kind
    when [4, 1] then :four_of_kind
    when [3, 2] then :full_house
    when [3, 1, 1] then :three_of_kind
    when [2, 2, 1] then :two_pairs
    when [2, 1, 1, 1] then :one_pair
    else :high_card
    end
  end
end


class Day07
  class << self
    def call
      file = File.read('lib/day07/input1.txt')
      process(file)
    end

    def process(input)
      input = input.split("\n")

      all_hands = input.map do |hand|
        hand.split => combination, bid
        Hand.new(combination, bid)
      end.sort

      all_hands.each_with_index.sum do |hand, index|
        hand.bid * (index + 1)
      end
    end

    def assign_rank_for(combination, bid)
      Hand.new(combination, bid)
    end
  end
end

class Test < Minitest::Test
  def test_day7_part1
    assert_data = <<~DATA
      32T3K 765
      T55J5 684
      KK677 28
      KTJJT 220
      QQQJA 483
    DATA

    assert_equal 6440, Day07.process(assert_data)
  end
end
