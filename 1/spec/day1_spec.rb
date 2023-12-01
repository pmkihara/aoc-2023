require_relative '../lib/day1'
example = File.read(File.join(__dir__, '../lib/example.txt'))
example2 = File.read(File.join(__dir__, '../lib/example2.txt'))

describe '#simple_parse' do
  it 'should return the correct result' do
    expect(simple_parse('1abc2')).to eq 12
    expect(simple_parse('pqr3stu8vwx')).to eq 38
    expect(simple_parse('a1b2c3d4e5f')).to eq 15
    expect(simple_parse('treb7uchet')).to eq 77
  end
end

describe '#solve1' do
  it 'should return an Integer' do
    expect(solve1(example)).to be_a Integer
  end

  it 'should return the correct value' do
    expect(solve1(example)).to eq 142
  end
end

describe '#improved_parse' do
  it 'should return the correct value' do
    expect(improved_parse('two1nine')).to eq 29
    expect(improved_parse('eightwothree')).to eq 83
    expect(improved_parse('abcone2threexyz')).to eq 13
    expect(improved_parse('xtwone3four')).to eq 24
    expect(improved_parse('4nineeightseven2')).to eq 42
    expect(improved_parse('zoneight234')).to eq 14
    expect(improved_parse('7pqrstsixteen')).to eq 76
  end
end

describe '#solve2' do
  it 'should return the correct value' do
    expect(solve2(example)).to eq 142
    expect(solve2(example2)).to eq 281
  end
end
