input = File.read(File.join(__dir__, './input.txt'))

def winning_numbers(string)
  string.split(': ').last.scan(/\d+/).map(&:to_i)
end

def find_matches(winning_numbers, card_numbers)
  winning_numbers.intersection card_numbers
end

def card_points(matches)
  return 0 if matches.empty?

  2 ** (matches.length - 1)
end

def solve1(input)
  points = 0
  rows = input.lines.each do |line|
    card = line.chomp!.split(' | ')
    winning_numbers = card.first.split(': ').last.scan(/\d+/).map(&:to_i)
    card_numbers = card.last.scan(/\d+/).map(&:to_i)
    card_matches = find_matches(winning_numbers,card_numbers)
    points += card_points(card_matches)
  end
  points
end

def bonus_cards(cards_hash, card)
  return card[:bonus_count] if card[:bonus_count]

  bonus_count = card[:matches]
  card[:matches].times do |index|
    next_card = cards_hash[card[:id] + index + 1]
    bonus_count += next_card[:bonus_matches]
  end
  bonus_count
end

def card_hash(line, cards)
  line.chomp!
  card = line.split(' | ')
  card_name, card_info = card.first.split(': ')
  card_id = card_name.split('Card ').last.to_i
  cards[card_id] = {}
  cards[card_id][:id] = card_id
  cards[card_id][:wins] = card_info.scan(/\d+/).map(&:to_i)
  cards[card_id][:numbers] = card.last.scan(/\d+/).map(&:to_i)
  cards[card_id][:matches] = find_matches(cards[card_id][:wins],cards[card_id][:numbers]).length
  cards[card_id][:bonus_matches] = bonus_cards(cards, cards[card_id])
end

def solve2(input)
  cards = {}
  card_count = 0
  input.lines.reverse.each do |line|
    card_hash(line, cards)
    card_count += 1
  end
  cards.values.map{ |v| v[:bonus_matches] }.sum + cards.length
end

# p solve1(input) # 25571
# p solve2(input) # 8805731
