require_relative '../lib/day8'
example = File.read(File.join(__dir__, '../lib/example.txt'))
example2 = File.read(File.join(__dir__, '../lib/example2.txt'))
example3 = File.read(File.join(__dir__, '../lib/example3.txt'))

describe '#solve1' do
  it 'should return the correct value' do
    expect(solve1(example)).to eq 2
    expect(solve1(example2)).to eq 6
  end
end

describe '#solve2' do
  it 'should return the correct value' do
    expect(solve2(example3)).to eq 6
  end
end
