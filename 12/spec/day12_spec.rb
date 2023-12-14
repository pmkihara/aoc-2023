require_relative '../lib/day12'
example = File.read(File.join(__dir__, '../lib/example.txt'))

describe '#count_arrangements' do
  it 'should return the correct number of different arrangements' do
    expect(count_arrangements([['???.###', [1, 1, 3]]])).to eq 1
    expect(count_arrangements([['.??..??...?##.', [1, 1, 3]]])).to eq 4
    expect(count_arrangements([['?#?#?#?#?#?#?#?', [1, 3, 1, 6]]])).to eq 1
    expect(count_arrangements([['????.#...#...', [4, 1, 1]]])).to eq 1
    expect(count_arrangements([['????.######..#####.', [1, 6, 5]]])).to eq 4
    expect(count_arrangements([['?###????????', [3, 2, 1]]])).to eq 10
  end
end

describe '#solve1' do
  it 'should return the correct value' do
    expect(solve1(example)).to eq 21
  end
end
