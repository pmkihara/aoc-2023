# frozen_string_literal: true

require 'pry-byebug'
input = File.read(File.join(__dir__, './input.txt'))

class Galaxy
  @@all = []
  @@rows = []
  @@cols = []

  attr_reader :original_x, :original_y, :x, :y

  def initialize(attrs = {})
    @x = attrs[:x]
    @y = attrs[:y]
    @@all << self
    @@cols << attrs[:x]
    @@rows << attrs[:y]
  end

  def expand_y!(increase)
    @y += increase
  end

  def expand_x!(increase)
    @x += increase
  end

  def self.all
    @@all
  end

  def self.rows
    @@rows
  end

  def self.cols
    @@cols
  end
end

def map_galaxies(input)
  input.lines.each_with_index do |row, row_i|
    row.chomp.chars.each_with_index do |col, col_i|
      Galaxy.new(x: col_i, y: row_i) if col == '#'
    end
  end
  Galaxy.all
end

def expand_galaxies!(total_rows, total_cols, ratio = 2)
  empty_rows = (0...total_rows).to_a - Galaxy.rows
  empty_cols = (0...total_cols).to_a - Galaxy.cols
  Galaxy.all.each do |galaxy|
    galaxy.expand_x!((empty_cols.count { |col| col < galaxy.x }) * (ratio - 1))
    galaxy.expand_y!((empty_rows.count { |row| row < galaxy.y }) * (ratio - 1))
  end
end

def find_pairs
  Galaxy.all.combination(2).to_a
end

def shortest_path(pair)
  a, b = pair
  (a.x - b.x).abs + (a.y - b.y).abs
end

def solve1(input)
  map_galaxies(input)
  expand_galaxies!(input.lines.length, input.lines.first.chomp.length)
  pairs = find_pairs
  pairs.map { |pair| shortest_path(pair) }.sum
end

# p solve1(input) # => 9591768

def solve2(input, ratio)
  map_galaxies(input)
  expand_galaxies!(input.lines.length, input.lines.first.chomp.length, ratio)
  pairs = find_pairs
  pairs.map { |pair| shortest_path(pair) }.sum
end

#  p solve2(input, 1_000_000) # => 746962844814 too high
