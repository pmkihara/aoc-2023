# frozen_string_literal: true

require 'pry-byebug'
input = File.read(File.join(__dir__, './input.txt'))

INSTRUCTIONS = [
  'seed-to-soil map:',
  'soil-to-fertilizer map:',
  'fertilizer-to-water map:',
  'water-to-light map:',
  'light-to-temperature map:',
  'temperature-to-humidity map:',
  'humidity-to-location map:'
]

def seeds(seeds_instructions)
  seeds_instructions.scan(/\d+/).map(&:to_i)
end

def map_modifier(instruction, map)
  name, *items = instruction.split("\n")
  map[name] = {}
  items.each do |item|
    d_start, s_start, range = item.split.map(&:to_i)
    map[name][s_start...(s_start + range)] = (d_start...(d_start + range))
  end
  map
end

def find_value_in_range(number, hash)
  hash.each do |range, value|
    return number + (value.begin - range.begin) if range.include?(number)
  end
  number
end

def find_seed_location(seed, map)
  location = seed
  INSTRUCTIONS.each do |instruction|
    location = find_value_in_range(location, map[instruction])
  end
  location
end

def build_map(instructions)
  map = {}
  instructions.each do |instruction|
    map_modifier(instruction, map)
  end
  map
end

def solve1(input)
  seeds_instructions, *instructions = input.split("\n\n")
  map = build_map(instructions)
  seeds = seeds(seeds_instructions)
  seeds.map { |seed| find_seed_location(seed, map) }.min
end

def range_intersection(source, destination)
  min = if destination.cover?(source.min)
          source.min
        elsif source.cover?(destination.min)
          destination.min
        end
  max = if destination.cover?(source.max)
          source.max
        elsif source.cover?(destination.max)
          destination.max
        end
  return nil if min.nil? || max.nil?

  min...(max + 1)
end

def remove_ranges(original_range, ranges_to_remove)
  result = [original_range]

  # if the range to remove is completely inside of the original range, get the right and left parts
  ranges_to_remove.each do |range_to_remove|
    partial_result = []
    result.each do |result_range|
      unless result_range.cover?(range_to_remove.min) || result_range.cover?(range_to_remove.max)
        partial_result << result_range
        next
      end
      left_result = range_to_remove.min <= result_range.min ? nil : (result_range.min)...(range_to_remove.min)
      right_result = range_to_remove.max >= result_range.max ? nil : (range_to_remove.end)...result_range.end
      partial_result.push(left_result, right_result).compact!
    end
    result = partial_result
  end
  result
end

def merge_ranges(original_key, original_value, modified_locations)
  modified_locations.map(&:keys).flatten
  modified_ranges = modified_locations.map(&:keys).flatten.sort_by(&:first)
  original_ranges = remove_ranges(original_key, modified_ranges)
  original_ranges.each do |range|
    modified_locations << { range => original_value }
    modified_locations
  end
  modified_locations.inject(&:merge)
end

def find_locations_in_range(loc_key, loc_value, instruction)
  all_locations = []

  instruction.each do |inst_key, inst_value|
    locations = {}
    # Location will follow instructions fully if completely inside the range
    inst_offset = inst_value.begin - inst_key.begin
    if inst_key.cover?(loc_value)
      locations[loc_key] = (loc_value.begin + inst_offset)...(loc_value.end + inst_offset)
      all_locations << locations
      next
    end
    intersection = range_intersection(loc_value, inst_key)
    # Do not map if no intersection
    next if intersection.nil?

    # If partially intersects, split the loc key
    locations.delete(loc_key)
    left_split_count = intersection.begin - loc_value.begin
    right_split_count = (loc_value.max - loc_value.min) - (intersection.max - intersection.min) - left_split_count
    inter_start = loc_key.begin + left_split_count
    inter_end = loc_key.end - right_split_count

    # Update the intersection with the instruction value
    locations[inter_start...inter_end] = (intersection.begin + inst_offset)...(intersection.end + inst_offset)

    all_locations << locations
  end
  # If no intersection, return the original value
  if all_locations.empty?
    { loc_key => loc_value }
  elsif all_locations.first.keys == [loc_key]
    all_locations.first
  else
    merge_ranges(loc_key, loc_value, all_locations)
  end
end

def seed_locations(seed, map)
  locations = seed.dup
  INSTRUCTIONS.each do |instruction|
    new_locations = []
    locations.each do |loc_key, loc_value|
      new = find_locations_in_range(loc_key, loc_value, map[instruction])
      new_locations << new
    end
    locations = new_locations.inject(:merge)
  end
  locations
end

def solve2(input)
  seeds_instructions, *instructions = input.split("\n\n")
  map = build_map(instructions)
  seeds = seeds(seeds_instructions)
  seeds_ranges = seeds.map.with_index do |num, i|
    next if i.odd?

    num...(num + seeds[i + 1])
  end.compact
  seeds_ranges.map do |seed|
    seed_locations({ seed => seed }, map).min_by { |_, v| v.begin }.last.min
  end.min
end

# p solve1(input) # 525792406
# p solve2(input) # 79004094
