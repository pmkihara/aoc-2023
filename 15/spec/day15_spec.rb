require_relative '../lib/day15'
example = File.read(File.join(__dir__, '../lib/example.txt'))

describe '#hash_value' do
  it 'should return the correct value' do
    expect(hash_value('HASH')).to eq 52
    expect(hash_value('rn=1')).to eq 30
    expect(hash_value('cm-')).to eq 253
    expect(hash_value('qp=3')).to eq 97
    expect(hash_value('cm=2')).to eq 47
    expect(hash_value('qp-')).to eq 14
    expect(hash_value('pc=4')).to eq 180
    expect(hash_value('ot=9')).to eq 9
    expect(hash_value('ab=5')).to eq 197
    expect(hash_value('pc-')).to eq 48
    expect(hash_value('pc=6')).to eq 214
    expect(hash_value('ot=7')).to eq 231
  end
end

describe '#focusing_power' do
  it 'should return the correct value' do
    expect(focusing_power({:label=>"rn", :number=>"1"}, 0, 0)).to eq 1
    expect(focusing_power({:label=>"cm", :number=>"2"}, 0, 1)).to eq 4
    expect(focusing_power({:label=>"ot", :number=>"7"}, 3, 0)).to eq 28
    expect(focusing_power({:label=>"ab", :number=>"5"}, 3, 1)).to eq 40
    expect(focusing_power({:label=>"pc", :number=>"6"}, 3, 2)).to eq 72
  end
end

describe '#solve1' do
  it 'should return the correct value' do
    expect(solve1(example)).to eq 1320
  end
end

describe '#solve2' do
  it 'should return the correct value' do
    expect(solve2(example)).to eq 145
  end
end
