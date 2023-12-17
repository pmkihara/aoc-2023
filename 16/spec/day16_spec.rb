require_relative '../lib/day16'
example = File.read(File.join(__dir__, '../lib/example.txt'))

describe 'Tile class' do
  before :each do
    create_tiles(example)
  end

  after :each do
    Object.send(:remove_const, 'Tile')
    load 'lib/day16.rb'
  end

  describe '#energize!' do
    it 'should energize a tile' do
      tile = Tile.class_variable_get(:@@all)[[0, 0]]
      expect(tile.energized).to eq []
      tile.energize!('left')
      expect(tile.energized).to eq ['left']
      expect(Tile.class_variable_get(:@@all_energized).length).to eq 1
    end

    it 'should not reinsert the tile in the energized array if it has already been visited' do
      tile = Tile.class_variable_get(:@@all)[[0, 0]]
      tile.energize!('left')
      expect(tile.energized).to eq ['left']
      tile.energize!('left')
      expect(tile.energized).to eq ['left']
      expect(Tile.class_variable_get(:@@all_energized).length).to eq 1
    end
  end

  describe '#next_tiles' do
    it 'should return the next tiles in the same direction when the value is "."' do
      tile = Tile.class_variable_get(:@@all)[[0, 0]]
      next_tiles = tile.next_tiles('right')
      expect(next_tiles.length).to eq 1
      expect(next_tiles.first[:tile]).to eq Tile.class_variable_get(:@@all)[[1, 0]]
      expect(next_tiles.first[:direction]).to eq 'right'
    end

    it 'should return change directions when encountering a diagonal "\" mirror' do
      tile = Tile.class_variable_get(:@@all)[[5, 0]]
      next_tiles = tile.next_tiles('right')
      expect(next_tiles.length).to eq 1
      expect(next_tiles.first[:tile]).to eq Tile.class_variable_get(:@@all)[[5, 1]]
      expect(next_tiles.first[:direction]).to eq 'down'
    end

    it 'should return change directions when encountering a diagonal "/" mirror' do
      tile = Tile.class_variable_get(:@@all)[[4, 6]]
      next_tiles = tile.next_tiles('right')
      expect(next_tiles.length).to eq 1
      expect(next_tiles.first[:tile]).to eq Tile.class_variable_get(:@@all)[[4, 5]]
      expect(next_tiles.first[:direction]).to eq 'up'
    end

    it 'should return split when encountering a "|" mirror when walking horizontally' do
      tile = Tile.class_variable_get(:@@all)[[5, 2]]
      next_tiles = tile.next_tiles('right')
      expect(next_tiles.length).to eq 2
      expect(next_tiles.map { |t| t[:tile] }).to include Tile.class_variable_get(:@@all)[[5, 1]]
      expect(next_tiles.map { |t| t[:tile] }).to include Tile.class_variable_get(:@@all)[[5, 3]]
      expect(next_tiles.map { |t| t[:direction] }).to include 'up'
      expect(next_tiles.map { |t| t[:direction] }).to include 'down'
    end

    it 'should return not split when encountering a "|" mirror when walking vertically' do
      tile = Tile.class_variable_get(:@@all)[[5, 2]]
      next_tiles = tile.next_tiles('up')
      expect(next_tiles.length).to eq 1
      expect(next_tiles.first[:tile]).to eq Tile.class_variable_get(:@@all)[[5, 1]]
      expect(next_tiles.first[:direction]).to eq 'up'
    end
  end
end

describe 'Full implementation' do
  after :each do
    Object.send(:remove_const, 'Tile')
    load 'lib/day16.rb'
  end

  describe '#solve1' do
    it 'should return the correct value' do
      expect(solve1(example)).to eq 46
    end
  end

  describe '#solve2' do
    it 'should return the correct value' do
      expect(solve2(example)).to eq 51
    end
  end
end
