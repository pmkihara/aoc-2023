require_relative '../lib/day7'
example = File.read(File.join(__dir__, '../lib/example.txt'))

describe '#hand_type' do
  it 'should identify a five of a kind' do
    expect(hand_type('AAAAA')).to eq 6
  end

  it 'should identify a four of a kind' do
    expect(hand_type('AA8AA')).to eq 5
  end

  it 'should identify a full house' do
    expect(hand_type('23332')).to eq 4
  end

  it 'should identify a three of a kind' do
    expect(hand_type('TTT98')).to eq 3
  end

  it 'should identify a two pair' do
    expect(hand_type('23432')).to eq 2
  end

  it 'should identify a one pair' do
    expect(hand_type('A23A4')).to eq 1
  end

  it 'should identify a high card' do
    expect(hand_type('23456')).to eq 0
  end
end

describe '#card_values' do
  it 'should get the right value of the cards' do
    expect(card_values('32T3K')).to eq [1, 0 , 8, 1, 11]
    expect(card_values('T55J5')).to eq [8, 3 , 3, 9, 3]
  end
end

describe '#solve1' do
  it 'should return the correct value' do
    expect(solve1(example)).to eq 6440
  end
end

describe '#joker_hand_type' do
  it 'should return the correct value' do
    expect(joker_hand_type('QJJQ2')).to eq 5
    expect(joker_hand_type('32T3K')).to eq 1
    expect(joker_hand_type('T55J5')).to eq 5
    expect(joker_hand_type('KTJJT')).to eq 5
    expect(joker_hand_type('QQQJA')).to eq 5
    expect(joker_hand_type('AAAAA')).to eq 6
    expect(joker_hand_type('JJJJJ')).to eq 6
  end
end

describe '#solve2' do
  it 'should return the correct value' do
    expect(solve2(example)).to eq 5905
  end
end
