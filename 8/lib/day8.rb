# frozen_string_literal: true

require 'pry-byebug'
input = File.read(File.join(__dir__, './input.txt'))

def build_map(coords_raw)
  map = {}
  coords_raw.split("\n").each do |line|
    origin, options = line.split(' = ')
    map[origin] = options.scan(/\w+/)
  end
  map
end

def travel(directions, location, map, steps_counter)
  return steps_counter if location == 'ZZZ'

  directions.each do |direction|
    location = direction == 'L' ? map[location].first : map[location].last
    steps_counter += 1
    break if location == 'ZZZ'
  end

  travel(directions, location, map, steps_counter)
end

def travel_to_z(directions, location, map, steps_counter)
  return steps_counter if location.end_with?('Z')

  directions.each do |direction|
    location = direction == 'L' ? map[location].first : map[location].last
    steps_counter += 1
    break if location.end_with?('Z')
  end

  travel_to_z(directions, location, map, steps_counter)
end

def solve1(input)
  directions_raw, coords_raw = input.split("\n\n")
  directions = directions_raw.chars
  map = build_map(coords_raw)
  travel(directions, 'AAA', map, 0)
end

# p solve1(input) # 11567

def solve2(input)
  directions_raw, coords_raw = input.split("\n\n")
  directions = directions_raw.chars
  map = build_map(coords_raw)
  locations = map.keys.select { |coord| coord.end_with?('A') }
  z_steps = locations.map do |location|
    travel_to_z(directions, location, map, 0)
  end
  z_steps.reduce(:lcm)
end

# p solve2(input) # 9858474970153
