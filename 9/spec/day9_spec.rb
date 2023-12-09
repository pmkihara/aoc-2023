require_relative '../lib/day9'
example = File.read(File.join(__dir__, '../lib/example.txt'))

describe '#diff_sequence' do
  it 'should return the correct value' do
    expect(diff_sequence([0, 3, 6, 9, 12, 15])).to eq [3, 3, 3, 3, 3]
    expect(diff_sequence([3, 3, 3, 3, 3])).to eq [0, 0 ,0 ,0]
  end
end

describe '#sequences' do
  it 'should return the correct value' do
    expect(sequences([0, 3, 6, 9, 12, 15])).to eq [[0, 3, 6, 9, 12, 15], [3, 3, 3, 3, 3], [0, 0 ,0 ,0]]
  end
end

describe '#next_number' do
  it 'should return the correct value' do
    expect(next_number([[0, 3, 6, 9, 12, 15], [3, 3, 3, 3, 3], [0, 0, 0, 0]])).to eq 18
    expect(next_number([[1, 3, 6, 10, 15, 21], [2, 3, 4, 5, 6], [1, 1, 1, 1], [0, 0, 0]])).to eq 28
    expect(next_number([[10, 13, 16, 21, 30, 45], [3, 3, 5, 9, 15], [0, 2, 4, 6], [2, 2, 2], [0, 0]])).to eq 68
  end
end

describe '#previous_number' do
  it 'should return the correct value' do
    expect(previous_number([[0, 3, 6, 9, 12, 15], [3, 3, 3, 3, 3], [0, 0, 0, 0]])).to eq -3
    expect(previous_number([[1, 3, 6, 10, 15, 21], [2, 3, 4, 5, 6], [1, 1, 1, 1], [0, 0, 0]])).to eq 0
    expect(previous_number([[10, 13, 16, 21, 30, 45], [3, 3, 5, 9, 15], [0, 2, 4, 6], [2, 2, 2], [0, 0]])).to eq 5
  end
end

describe '#solve1' do
  it 'should return the correct value' do
    expect(solve1(example)).to eq 114
  end
end

describe '#solve2' do
  it 'should return the correct value' do
    expect(solve2(example)).to eq 2
  end
end
