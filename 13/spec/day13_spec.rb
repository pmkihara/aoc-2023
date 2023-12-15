require_relative '../lib/day13'
example = File.read(File.join(__dir__, '../lib/example.txt'))

describe '#solve1' do
  it 'should return the correct value' do
    expect(solve1(example)).to eq 405
  end
end

describe '#solve2' do
  it 'should return the correct value' do
    expect(solve2(example)).to eq 400
  end
end
