require_relative '../lib/day2'
example = File.read(File.join(__dir__, '../lib/example.txt'))

describe '#max_cubes' do
  it 'should count the cubes' do
    expect(max_cubes('Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green')).to include({
      'game' => 1,
      'red' => 4,
      'green' => 2,
      'blue' => 6
    })
    expect(max_cubes('Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue')).to include({
      'game' => 2,
      'red' => 1,
      'green' => 3,
      'blue' => 4
    })
    expect(max_cubes('Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red')).to include({
      'game' => 3,
      'red' => 20,
      'green' => 13,
      'blue' => 6
    })
    expect(max_cubes('Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red')).to include({
      'game' => 4,
      'red' => 14,
      'green' => 3,
      'blue' => 15
    })
    expect(max_cubes('Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green')).to include({
      'game' => 5,
      'red' => 6,
      'green' => 3,
      'blue' => 2
    })
  end
end

describe '#enough_cubes?' do
  it 'should be true if there are enough cubes' do
    expect(enough_cubes?(max_cubes('Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green'))).to eq true
    expect(enough_cubes?(max_cubes('Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue'))).to eq true
    expect(enough_cubes?(max_cubes('Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green'))).to eq true
  end

  it 'should be false if there are not enough cubes' do
    expect(enough_cubes?(max_cubes('Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red'))).to eq false
    expect(enough_cubes?(max_cubes('Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red'))).to eq false
  end
end

describe '#solve1' do
  it 'should return the correct result' do
    expect(solve1(example)).to eq 8
  end
end

describe '#cubes_power' do
  it 'should return the correct result' do
    expect(cubes_power(max_cubes('Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green'))).to eq 48
    expect(cubes_power(max_cubes('Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue'))).to eq 12
    expect(cubes_power(max_cubes('Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red'))).to eq 1560
    expect(cubes_power(max_cubes('Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red'))).to eq 630
    expect(cubes_power(max_cubes('Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green'))).to eq 36
  end
end

describe '#solve1' do
  it 'should return the correct result' do
    expect(solve2(example)).to eq 2286
  end
end
