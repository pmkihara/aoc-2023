# frozen_string_literal: true

require 'pry-byebug'
input = File.read(File.join(__dir__, './input.txt'))

COMBINATIONS = {}

def count_arrangements(queue, counter = 0)
  return counter if queue.empty?

  current = queue.shift
  string = current.first
  numbers = current.last

  # Is a valid sequence if there are no more string chars and no more numbers
  # Is a valid sequence if there are no more numbers and the string doesn't have more "#"
  counter += 1 if (string.empty? && numbers.empty?) || (numbers.empty? && !string.match?('#'))

  unless string.empty? || numbers.empty?
    # Is not valid if the string isn't long enough for the numbers, do not add the rest
    too_short = string.length < numbers.sum + numbers.length - 1
    unless too_short
      rest_of_string = string[1..]
      case string[0]
      when '.'
        # Go to the next character if the first character is a "."
        queue.unshift([rest_of_string, numbers])
      when '#'
        # Is not valid if there is a "." in the substring or if the character right after the
        # substring is a "#""
        number, *rest_of_numbers = numbers
        substring = string.slice!(0...number)
        queue.unshift([(string[1..] || ''), rest_of_numbers]) unless substring.match?(/\./) || string[0] == '#'
      when '?'
        # Branch if the string starts with "?"
        queue.unshift(["##{rest_of_string}", numbers])
        queue.unshift([".#{rest_of_string}", numbers])
      end
    end
  end
  count_arrangements(queue, counter)
end

def solve1(input)
  count = 0
  input.lines.each do |line|
    string, nums_raw = line.chomp.split
    numbers = nums_raw.split(',').map(&:to_i)
    if COMBINATIONS[[string, numbers]]
      count += COMBINATIONS[[string, numbers]]
    else
      result = count_arrangements([[string, numbers]])
      COMBINATIONS[[string, numbers]] = result
      count += result
    end
  end
  count
end

p solve1(input) # 8193

def solve2(input)
  count = 0
  input.lines.each do |line|
    string, nums_raw = line.chomp.split
    numbers = nums_raw.split(',').map(&:to_i)
    unfolded_string = string * 5
    unfolded_numbers = numbers * 5
    if COMBINATIONS[[unfolded_string, unfolded_numbers]]
      count += COMBINATIONS[[unfolded_string, unfolded_numbers]]
    else
      result = count_arrangements([[unfolded_string, unfolded_numbers]])
      COMBINATIONS[[unfolded_string, unfolded_numbers]] = result
      count += result
    end
  end
  count
end

p solve2(input)
