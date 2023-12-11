require_relative '../lib/day10'
example = File.read(File.join(__dir__, '../lib/example.txt'))
example2 = File.read(File.join(__dir__, '../lib/example2.txt'))
example3 = File.read(File.join(__dir__, '../lib/example3.txt'))
example4 = File.read(File.join(__dir__, '../lib/example4.txt'))
example5 = File.read(File.join(__dir__, '../lib/example5.txt'))

describe '#solve1' do
  after :each do
    Object.send(:remove_const, 'Node')
    load 'lib/day10.rb'
  end

  it 'should return the correct value in a simple loop' do
    expect(solve1(example)).to eq 4
  end

  it 'should return the correct value in a more complex loop' do
    expect(solve1(example2)).to eq 8
  end
end

describe '#solve2' do
  after :each do
    Object.send(:remove_const, 'Node')
    load 'lib/day10.rb'
  end

  it 'should return the correct value in a simple loop' do
    expect(solve2(example3)).to eq 4
  end

  it 'should return the correct value in a more complex loop' do
    expect(solve2(example4)).to eq 8
  end

  it 'should return the correct value in a loop with junk' do
    expect(solve2(example5)).to eq 10
  end
end
