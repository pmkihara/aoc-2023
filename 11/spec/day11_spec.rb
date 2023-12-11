require_relative '../lib/day11'
example = File.read(File.join(__dir__, '../lib/example.txt'))
mapped_galaxies = [[3, 0], [7, 1], [0, 2], [6, 4], [1, 5], [9, 6], [7, 8], [0, 9], [4, 9]]
expanded_galaxies = [[4, 0], [9, 1], [0, 2], [8, 5], [1, 6], [12, 7], [9, 10], [0, 11], [5, 11]]
expanded_far_galaxies = [[12, 0], [25, 1], [0, 2], [24, 13], [1, 14], [36, 15], [25, 26], [0, 27], [13, 27]]

describe 'Day 11' do
  before :each do
    map_galaxies(example)
  end

  after :each do
    Object.send(:remove_const, 'Galaxy')
    load 'lib/day11.rb'
  end

  describe '#map_galaxies' do
    it 'should return the correct value' do
      expect(Galaxy.all.length).to eq 9
      expect(Galaxy.all.map { |g| [g.x, g.y] }).to eq mapped_galaxies
    end
  end

  describe '#expand_galaxies!' do
    it 'should update the galaxies positions' do
      total_rows = example.lines.length
      total_cols = example.lines.first.chomp.length
      expand_galaxies!(total_rows, total_cols)
      expect(Galaxy.all.map { |g| [g.x, g.y] }).to eq expanded_galaxies
    end

    it 'should update the galaxies positions with ratio' do
      total_rows = example.lines.length
      total_cols = example.lines.first.chomp.length
      expand_galaxies!(total_rows, total_cols, 10)
      expect(Galaxy.all.map { |g| [g.x, g.y] }).to eq expanded_far_galaxies
    end
  end

  describe '#find_pairs' do
    it 'should return pairs without repetition' do
      expect(find_pairs.length).to eq 36
    end
  end

  describe '#shortest_path' do
    it 'should return the correct distance' do
      expect(shortest_path([Galaxy.new(x: 1, y: 6), Galaxy.new(x: 5, y: 11)])).to eq 9
      expect(shortest_path([Galaxy.new(x: 4, y: 0), Galaxy.new(x: 9, y: 10)])).to eq 15
      expect(shortest_path([Galaxy.new(x: 0, y: 2), Galaxy.new(x: 12, y: 7)])).to eq 17
      expect(shortest_path([Galaxy.new(x: 0, y: 11), Galaxy.new(x: 5, y: 11)])).to eq 5
    end
  end
end

describe 'solutions' do
  after :each do
    Object.send(:remove_const, 'Galaxy')
    load 'lib/day11.rb'
  end

  describe '#solve1' do
    it 'should return the correct value' do
      expect(solve1(example)).to eq 374
    end
  end

  describe '#solve2' do
    it 'should return the correct value' do
      expect(solve2(example, 10)).to eq 1030
    end
    it 'should return the correct value' do
      expect(solve2(example, 100)).to eq 8410
    end
  end
end
