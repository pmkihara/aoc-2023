# frozen_string_literal: true

require 'pry-byebug'

# TODO: This implementation doesn't work yet because the Dijkstra algorythm as
# applied here calculates the shortest distance considering only the immediate
# neighbours. However, the 3 movements in the same direction rule doesn't only
# mean that the path forward needs to be removed from the neighbours, but also
# that there might be a less expensive path by choosing a previous node that is
# more expensive at the time of the calculation, but that will have a less
# expensive total cost later. For example:
# 11599
# 99199
# 99199
# 99199
# 99111
# Removing only the forward neighbour gives a result of 20, but there is a less
# expensive path (result of 16) by turning into 9 [1, 1] instead of 5 [0, 2].

class Node
  @@all = {}
  @@unvisited = []

  attr_reader :value, :x, :y, :visited
  attr_accessor :parent, :distance

  def initialize(attrs = {})
    @x = attrs[:x]
    @y = attrs[:y]
    @value = attrs[:value]
    @distance = @x.zero? && @y.zero? ? 0 : Float::INFINITY
    @parent = nil
    @visited = false
    @@all[[@x, @y]] = self
    @@unvisited << self
  end

  def visit!
    @visited = true
    @@unvisited.delete(self)
  end

  def neighbours
    # Can't be a neighbour if already visited or if the last 3 steps were in the same direction
    neighbours = []

    right = @@all[[@x + 1, @y]]
    neighbours << right unless right.nil? || right.visited || same_direction?('right')

    left = @@all[[@x - 1, @y]]
    neighbours << left unless left.nil? || left.visited || same_direction?('left')

    top = @@all[[@x, @y - 1]]
    neighbours << top unless top.nil? || top.visited || same_direction?('up')

    bottom = @@all[[@x, @y + 1]]
    neighbours << bottom unless bottom.nil? || bottom.visited || same_direction?('down')
    neighbours
  end

  def set_shortest_distance(parent, distance)
    return if @distance < distance

    @parent = parent
    @distance = distance
  end

  def same_direction?(direction)
    case direction
    when 'right'
      !!(@parent && @parent.y == @y && @parent.x == @x - 1) &&
        !!(@parent.parent && @parent.parent.y == @y && @parent.parent.x == @x - 2) &&
        !!(@parent.parent.parent && @parent.parent.parent.y == @y && @parent.parent.parent.x == @x - 3)
    when 'left'
      !!(@parent && @parent.y == @y && @parent.x == @x + 1) &&
        !!(@parent.parent && @parent.parent.y == @y && @parent.parent.x == @x + 2) &&
        !!(@parent.parent.parent && @parent.parent.parent.y == @y && @parent.parent.parent.x == @x + 3)
    when 'down'
      !!(@parent && @parent.x == @x && @parent.y == @y - 1) &&
        !!(@parent.parent && @parent.parent.x == @x && @parent.parent.y == @y - 2) &&
        !!(@parent.parent.parent && @parent.parent.parent.x == @x && @parent.parent.parent.y == @y - 3)
    when 'up'
      !!(@parent && @parent.x == @x && @parent.y == @y + 1) &&
        !!(@parent.parent && @parent.parent.x == @x && @parent.parent.y == @y + 2) &&
        !!(@parent.parent.parent && @parent.parent.parent.x == @x && @parent.parent.parent.y == @y + 3)
    end
  end

  def trace_path
    parent = @parent
    until parent.nil?
      p [parent.x, parent.y]
      parent = parent.parent
    end
  end

  def self.all
    @@all
  end

  def self.lowest_unvisited
    @@unvisited.min_by(&:distance)
  end
end

def create_nodes(input)
  input.lines.each_with_index do |row, y|
    row.chomp.chars.each_with_index do |char, x|
      Node.new({ x: x, y: y, value: char.to_i })
    end
  end
end

def find_shortest_path(start, destination)
  return if start.nil?

  start.visit!
  start.neighbours.each do |neighbour|
    neighbour.set_shortest_distance(start, start.distance + neighbour.value)
  end
  next_node = Node.lowest_unvisited
  find_shortest_path(next_node, destination)
end

def solve1(input)
  create_nodes(input)
  start = Node.all[[0, 0]]
  destination = Node.all[[input.lines.first.chomp.length - 1, input.lines.length - 1]]
  find_shortest_path(start, destination)
  destination.trace_path
  destination.distance
end
