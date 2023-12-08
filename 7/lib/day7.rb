# frozen_string_literal: true

require 'pry-byebug'
input = File.read(File.join(__dir__, './input.txt'))

CARDS = %w[2 3 4 5 6 7 8 9 T J Q K A].freeze
JOKER_CARDS = %w[J 2 3 4 5 6 7 8 9 T Q K A].freeze

def hand_type(hand)
  n_cards = hand.chars.tally.values.sort
  case n_cards
  when [1, 1, 1, 1, 1] then 0 # high card
  when [1, 1, 1, 2] then 1 # one pair
  when [1, 2, 2] then 2 # two pair
  when [1, 1, 3] then 3 # three of a kind
  when [2, 3] then 4 # full house
  when [1, 4] then 5 # four of a kind
  when [5] then 6 # five of a kind
  end
end

def joker_hand_type(hand)
  n_jokers = hand.scan('J').length
  original_type = hand_type(hand)
  return original_type if original_type == 6 || n_jokers.zero?

  case original_type
  when 5 then 6 # four of a kind => five of a kind
  when 4 then 6 # full house => five of a kind
  when 3 then 5 # three of a kind => four of a kind
  when 2 then n_jokers == 2 ? 5 : 4 # two pair => four of a kind if J * 2 or full house if J * 1
  when 1 then 3 # one pair => three of a kind
  when 0 then 1 # high card => one pair
  end
end

def card_values(hand)
  hand.chars.map { |card| CARDS.index(card) }
end

def joker_card_values(hand)
  hand.chars.map { |card| JOKER_CARDS.index(card) }
end

def sort_hands(hands)
  hands.sort_by do |_hand, value|
    [value[:type], value[:values][0], value[:values][1], value[:values][2], value[:values][3], value[:values][4]]
  end
end

def hand_winnings(bid, rank)
  bid * rank
end

def solve1(input)
  hands = {}
  input.lines.each do |line|
    hand, bid = line.chomp.split
    hands[hand] = {
      bid: bid.to_i,
      type: hand_type(hand),
      values: card_values(hand)
    }
  end
  total = 0
  sort_hands(hands).each_with_index do |hand, index|
    rank = index + 1
    bid = hand[1][:bid]
    total += hand_winnings(bid, rank)
  end
  total
end

def solve2(input)
  hands = {}
  input.lines.each do |line|
    hand, bid = line.chomp.split
    hands[hand] = {
      bid: bid.to_i,
      type: joker_hand_type(hand),
      values: joker_card_values(hand)
    }
  end
  total = 0
  sort_hands(hands).each_with_index do |hand, index|
    rank = index + 1
    bid = hand[1][:bid]
    total += hand_winnings(bid, rank)
  end
  total
end

# p solve1(input) # 248217452
# p solve2(input) # 245576185
