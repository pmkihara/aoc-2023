require_relative '../lib/day14'
example = File.read(File.join(__dir__, '../lib/example.txt'))

describe '#solve1' do
  it 'should return the correct value' do
    expect(solve1(example)).to eq 136
  end
end

describe '#solve2' do
  it 'should return the correct value' do
    expect(solve2(example)).to eq 64
  end
end
