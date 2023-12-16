# frozen_string_literal: true

require 'pry-byebug'
input = File.read(File.join(__dir__, './input.txt'))

def hash_value(string)
  string.chars.reduce(0) do |current_value, char|
    current_value += char.ord
    current_value *= 17
    current_value %= 256
  end
end

def focusing_power(lens, index, box_number)
  # pry.byebug
  (1 + box_number) * (index + 1) * lens[:number].to_i
end

def solve1(input)
  lenses = input.chomp.split(',')
  lenses.sum { |lens| hash_value(lens) }
end

# p solve1(input) # => 518107

def solve2(input)
  lenses = input.chomp.split(',')
  boxes = {}
  lenses.each do |lens_string|
    match = lens_string.match(/(?<label>\w+)(?<operation>[-=])(?<number>\d+)?/)
    box_number = hash_value(match[:label])
    boxes[box_number] ||= []

    # If the operation is "-", remove the lens from the corresponding box if it's in the box
    boxes[box_number].delete_if { |box_lens| box_lens[:label] == match[:label] } if match[:operation] == '-'

    # If the operation is "="
    if match[:operation] == '='
      lens_index = boxes[box_number].index { |box_lens| box_lens[:label] == match[:label] }
      if lens_index
        # If there's already a lens in the box with the same label, replace the old lens with the new lens (update number)
        boxes[box_number][lens_index][:number] = match[:number]
      else
        # If there is not already a lens in the box with the same label, add the lens to the box
        boxes[box_number] << {label: match[:label], number: match[:number]}
      end
    end
  end
  boxes.sum { |box_n, box| box.map.with_index {|lens, index| focusing_power(lens, index, box_n) }.sum }
end

p solve2(input) # => 303404
