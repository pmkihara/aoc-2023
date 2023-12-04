require_relative '../lib/day3'
example = File.read(File.join(__dir__, '../lib/example.txt'))

describe '#find_adjacent_numbers' do
  it 'returns the correct numbers' do
    expect(find_adjacent_numbers('123...456...', 2)).to eq [123]
    expect(find_adjacent_numbers('..35..633.', 3)).to eq [35]
  end
end

describe '#solve1' do
  it 'returns the correct value' do
    expect(solve1(example)).to eq 4361
  end
end

describe '#solve1' do
  it 'returns the correct value' do
    expect(solve2(example)).to eq 467835
  end
end
