# frozen_string_literal: true

require 'pry-byebug'
input = File.read(File.join(__dir__, './input.txt'))

class LightBeam
  def initialize(attrs = {})
    @direction = attrs[:direction] || 'right'
    @tile = attrs[:tile]
  end

  def move!
    @tile.energize!(@direction)
    next_tiles = @tile.next_tiles(@direction).compact
    return if next_tiles.empty?

    if next_tiles[1]
      split_beam = LightBeam.new(next_tiles[1])
      split_beam.move!
    end

    @tile = next_tiles.first[:tile]
    @direction = next_tiles.first[:direction]
    move!
  end
end

class Tile
  @@all = {}
  @@all_energized = []

  attr_reader :x, :y, :energized

  def initialize(attrs = {})
    @x = attrs[:x]
    @y = attrs[:y]
    @type = attrs[:type]
    @energized = []
    @@all[[@x, @y]] = self
  end

  def energize!(direction)
    return if @energized.include?(direction)

    @energized << direction
    @@all_energized << self
  end

  def disenergize!
    @energized = []
  end

  def left_tile
    tile = @@all[[@x - 1, @y]]
    return nil if tile.nil? || tile.energized.include?('left')

    { tile: tile, direction: 'left' }
  end

  def right_tile
    tile = @@all[[@x + 1, @y]]
    return nil if tile.nil? || tile.energized.include?('right')

    { tile: tile, direction: 'right' }
  end

  def upper_tile
    tile = @@all[[@x, @y - 1]]
    return nil if tile.nil? || tile.energized.include?('up')

    { tile: tile, direction: 'up' }
  end

  def lower_tile
    tile = @@all[[@x, @y + 1]]
    return nil if tile.nil? || tile.energized.include?('down')

    { tile: tile, direction: 'down' }
  end

  def next_tiles(direction)
    case @type
    when '.'
      case direction
      when 'left' then [left_tile]
      when 'right' then [right_tile]
      when 'up' then [upper_tile]
      when 'down' then [lower_tile]
      end
    when '/'
      case direction
      when 'left' then [lower_tile]
      when 'right' then [upper_tile]
      when 'up' then [right_tile]
      when 'down' then [left_tile]
      end
    when '\\'
      case direction
      when 'left' then [upper_tile]
      when 'right' then [lower_tile]
      when 'up' then [left_tile]
      when 'down' then [right_tile]
      end
    when '|'
      case direction
      when 'left' then [upper_tile, lower_tile]
      when 'right' then [upper_tile, lower_tile]
      when 'up' then [upper_tile]
      when 'down' then [lower_tile]
      end
    when '-'
      case direction
      when 'left' then[left_tile]
      when 'right' then [right_tile]
      when 'up' then [left_tile, right_tile]
      when 'down' then [left_tile, right_tile]
      end
    end
  end

  def self.all
    @@all
  end

  def self.energized_count
    @@all_energized.uniq.length
  end

  def self.print_energy_map(lines_count)
    lines_count.to_i.times do |i|
      puts @@all.select { |k, _v| k.last == i }.map { |_k, v| v.energized.empty? ? '.' : '#' }.join
    end
  end

  def self.reset!
    @@all.each do |_position, tile|
      tile.disenergize!
    end
    @@all_energized = []
  end
end

def create_tiles(input)
  input.lines.each_with_index do |row, y|
    row.chomp.chars.each_with_index do |char, x|
      Tile.new({ x: x, y: y, type: char })
    end
  end
end

def solve1(input)
  create_tiles(input)
  first_tile = Tile.all[[0, 0]]
  beam = LightBeam.new(tile: first_tile, direction: 'right')
  beam.move!
  # Tile.print_energy_map(input.lines.count)
  Tile.energized_count
end

def energize_tiles(position, direction, energies)
  beam = LightBeam.new(tile: Tile.all[position], direction: direction)
  beam.move!
  energies[position] = Tile.energized_count
  Tile.reset!
end

def solve2(input)
  create_tiles(input)
  last_index = input.lines.length - 1 # input has the same number of rows and columns
  energies = {}
  (1...last_index).each do |index|
    energize_tiles([0, index], 'right', energies) # left edges
    energize_tiles([last_index, index], 'left', energies) # right edges
    energize_tiles([index, 0], 'down', energies) # top edges
    energize_tiles([index, last_index], 'up', energies) # bottom edges
  end
  energies.max_by { |_k, v| v }.last
end

# p solve1(input) # => 6795
# p solve2(input) # => 7154
