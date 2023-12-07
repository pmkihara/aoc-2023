require_relative '../lib/day6'
example = File.read(File.join(__dir__, '../lib/example.txt'))

describe 'find_wins' do
  it 'returns the correct results' do
    expect(find_wins(7, 9)).to eq 4
    expect(find_wins(15, 40)).to eq 8
    expect(find_wins(30, 200)).to eq 9
  end
end

describe '#solve1' do
  it 'returns the correct value' do
    expect(solve1(example)).to eq 288
  end
end

describe '#solve2' do
  it 'returns the correct value' do
    expect(solve2(example)).to eq 71503
  end
end
