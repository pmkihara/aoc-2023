# frozen_string_literal: true

require 'pry-byebug'
input = File.read(File.join(__dir__, './input.txt'))

class Node
  @@all = {}
  @@start_node = nil
  @@visited_nodes = []

  attr_reader :value, :x, :y

  def initialize(attrs = {})
    @value = attrs[:value]
    @x = attrs[:x]
    @y = attrs[:y]
    @previous = nil
    @next = nil
    @visited = attrs[:start_node]
    @@start_node = self if attrs[:start_node]
    @@all[[@x, @y]] = self
    @@visited_nodes << self if attrs[:start_node]
  end

  def visit!(origin)
    @previous = origin
    @@visited_nodes << self
    @visited = true
  end

  def connected_tile(origin)
    case @value
    when '.' then nil
    when '|' then @y - 1 == origin.y ? @@all[[@x, @y + 1]] : @@all[[@x, @y - 1]]
    when '-' then @x - 1 == origin.x ? @@all[[@x + 1, @y]] : @@all[[@x - 1, @y]]
    when 'L' then @y - 1 == origin.y ? @@all[[@x + 1, @y]] : @@all[[@x, @y - 1]]
    when 'J' then @y - 1 == origin.y ? @@all[[@x - 1, @y]] : @@all[[@x, @y - 1]]
    when '7' then @x - 1 == origin.x ? @@all[[@x, @y + 1]] : @@all[[@x - 1, @y]]
    when 'F' then @x + 1 == origin.x ? @@all[[@x, @y + 1]] : @@all[[@x + 1, @y]]
    end
  end

  def neighbours
    neighbours = []

    right = @@all[[@x + 1, @y]]
    neighbours << right if right && %w[- 7 J].include?(right.value) && right != @previous

    left = @@all[[@x - 1, @y]]
    neighbours << left if left && %w[- F L].include?(left.value) && left != @previous

    top = @@all[[@x, @y - 1]]
    neighbours << top if top && %w[| 7 F].include?(top.value) && top != @previous

    bottom = @@all[[@x, @y + 1]]
    neighbours << bottom if bottom && %w[| L J].include?(bottom.value) && bottom != @previous

    neighbours
  end

  def is_inside?(nodes)
    # Ray casting algorithm: One simple way of finding whether the point is inside or outside a simple polygon is to
    # test how many times a ray, starting from the point and going in any fixed direction, intersects the edges of the
    # polygon. If the point is on the outside of the polygon the ray will intersect its edge an even number of times.
    # If the point is on the inside of the polygon then it will intersect the edge an odd number of times.
    previous_node = nodes.last
    inside = false
    nodes.sort_by(&:x).each do |node|
      # TODO: Handle running along the edges, for example ".|L-7.F-J|." (the middle dot shouldn't be inside)
      next unless @y == node.y && @x < node.x

      edge = (previous_node.value == 'L' && node.value == '7') || (previous_node.value == 'F' && node.value == 'J')
      inside = !inside unless edge
      previous_node = node
    end
    inside
  end

  def self.all
    @@all.values
  end

  def self.nodes
    @@visited_nodes.reject { |node| node.value == '-' }.sort_by(&:x)
  end

  def self.start_node
    @@start_node
  end

  def self.visited_nodes
    @@visited_nodes
  end

  def self.tiles
    @@tiles
  end
end

def populate_nodes(input)
  input.lines.each_with_index do |row, row_i|
    row.chomp.chars.each_with_index do |col, col_i|
      Node.new({ value: col, x: col_i, y: row_i, start_node: col == 'S' })
    end
  end
end

def draw_path!
  origin_node = Node.start_node
  neighbours = origin_node.neighbours
  next_node = neighbours.first
  until next_node == Node.start_node
    next_node.visit!(origin_node)
    connected_node = next_node.connected_tile(origin_node)
    origin_node = next_node
    next_node = connected_node
  end
end

def solve1(input)
  populate_nodes(input)
  draw_path!
  (Node.visited_nodes.length + 1) / 2
end

def solve2(input)
  populate_nodes(input)
  draw_path!
  tiles = Node.all - Node.visited_nodes
  nodes = Node.nodes
  inside = tiles.select { |t| t.is_inside?(nodes) }
  inside.count
end

# p solve1(input) # 6599
# p solve2(input) # 477
