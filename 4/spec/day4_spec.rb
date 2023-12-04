require_relative '../lib/day4'
example = File.read(File.join(__dir__, '../lib/example.txt'))

describe '#winning_numbers' do
  it 'returns the correct values' do
    expect(winning_numbers('Card 1: 41 48 83 86 17')).to eq [41, 48, 83, 86, 17]
    expect(winning_numbers('Card 2: 13 32 20 16 61')).to eq [13, 32, 20, 16, 61]
    expect(winning_numbers('Card 3:  1 21 53 59 44 ')).to eq [1, 21, 53, 59, 44]
    expect(winning_numbers('Card 4: 41 92 73 84 69 ')).to eq [41, 92, 73, 84, 69]
    expect(winning_numbers('Card 5: 87 83 26 28 32')).to eq [87, 83, 26, 28, 32]
    expect(winning_numbers('Card 6: 31 18 13 56 72')).to eq [31, 18, 13, 56, 72]
  end
end

describe '#find_matches' do
  it 'returns the card matches' do
    expect(find_matches([41, 48, 83, 86, 17], [83, 86, 6, 31, 17, 9, 48, 53])).to eq [48, 83, 86, 17]
  end
end

describe '#card_points' do
  it 'return the correct result' do
    expect(card_points([48, 83, 86, 17])).to eq 8
  end

  it 'returns 0 if there are no matches in the card' do
    expect(card_points([])).to eq 0
  end
end

describe '#solve1' do
  it 'returns the correct' do
    expect(solve1(example)).to eq 13
  end
end

describe '#solve2' do
  it 'returns the correct' do
    expect(solve2(example)).to eq 30
  end
end
