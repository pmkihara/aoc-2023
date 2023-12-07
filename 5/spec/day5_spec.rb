require_relative '../lib/day5'
example = File.read(File.join(__dir__, '../lib/example.txt'))

describe '#seeds' do
  it 'should return the seeds as an array of integers' do
    expect(seeds('seeds: 79 14 55 13')).to eq [79, 14, 55, 13]
  end
end

describe '#map_modifier' do
  it 'should return the correct correspondencies' do
    expect(map_modifier("seed-to-soil map:\n50 98 2\n52 50 48", {})).to eq(
      { 'seed-to-soil map:' => { 98...100 => 50...52, 50...98 => 52...100 } }
    )
  end
end

describe '#build_map' do
  it 'should return the correct correspondencies' do
    _seeds_instructions, *instructions = example.split("\n\n")
    expect(build_map(instructions)).to eq(
      {
        'seed-to-soil map:' => { 98...100 => 50...52, 50...98 => 52...100 },
        'soil-to-fertilizer map:' => { 15...52 => 0...37, 52...54 => 37...39, 0...15 => 39...54 },
        'fertilizer-to-water map:' => { 53...61 => 49...57, 11...53 => 0...42, 0...7 => 42...49, 7...11 => 57...61 },
        'water-to-light map:' => { 18...25 => 88...95, 25...95 => 18...88 },
        'light-to-temperature map:' => { 77...100 => 45...68, 45...64 => 81...100, 64...77 => 68...81 },
        'temperature-to-humidity map:' => { 69...70 => 0...1, 0...69 => 1...70 },
        'humidity-to-location map:' => { 56...93 => 60...97, 93...97 => 56...60 }
      }
    )
  end
end

describe '#find_value_in_range' do
  it 'should return the correct value' do
    expect(find_value_in_range(79, { 98...100 => 50...52, 50...98 => 52...100 })).to eq 81
    expect(find_value_in_range(14, { 98...100 => 50...52, 50...98 => 52...100 })).to eq 14
    expect(find_value_in_range(55, { 98...100 => 50...52, 50...98 => 52...100 })).to eq 57
    expect(find_value_in_range(13, { 98...100 => 50...52, 50...98 => 52...100 })).to eq 13
  end
end

describe '#find_seed_location' do
  it 'should return the correct value' do
    _seeds_instructions, *instructions = example.split("\n\n")
    map = build_map(instructions)
    expect(find_seed_location(79, map)).to eq 82
    expect(find_seed_location(14, map)).to eq 43
    expect(find_seed_location(55, map)).to eq 86
    expect(find_seed_location(13, map)).to eq 35
  end
end

describe '#solve1' do
  it 'runs' do
    expect(solve1(example)).to eq 35
  end
end

describe '#solve2' do
  it 'runs' do
    p solve2(example)
  end
end
