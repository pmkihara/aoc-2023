# frozen_string_literal: true

require 'pry-byebug'
input = File.read(File.join(__dir__, './input.txt'))

COMBINATIONS = {}

def count_arrangements(string, numbers)
  # Is a valid sequence if there are no more string chars and no more numbers
  # Is a valid sequence if there are no more numbers and the string doesn't have more "#"
  # Is not valid if the string isn't long enough for the numbers, do not add the rest
  return 1 if (string.empty? && numbers.empty?) || (numbers.empty? && !string.match?('#'))
  return 0 if string.empty? || numbers.empty? || string.length < numbers.sum + numbers.length - 1

  rest_of_string = string[1..]
  case string[0]
  when '.'
    # Go to the next character if the first character is a "."
    COMBINATIONS[[string, numbers]] ||= count_arrangements(rest_of_string, numbers)
  when '#'
    number, *rest_of_numbers = numbers
    substring = string.slice(0...number)

    # Is not valid if there is a "." in the substring or if the character right after the
    # substring is a "#""
    return 0 if substring.match?(/\./) || string[number] == '#'

    COMBINATIONS[[string, numbers]] ||= count_arrangements((string[(number + 1)..] || ''), rest_of_numbers)
  when '?'
    # Branch if the string starts with "?"
    COMBINATIONS[[string, numbers]] ||= (COMBINATIONS[["##{rest_of_string}", numbers]] ||= count_arrangements("##{rest_of_string}", numbers)) + (COMBINATIONS[[".#{rest_of_string}", numbers]] ||= count_arrangements(".#{rest_of_string}", numbers))
  end
end

def solve1(input)
  count = 0
  input.lines.each do |line|
    string, nums_raw = line.chomp.split
    numbers = nums_raw.split(',').map(&:to_i)
    result = COMBINATIONS[[string, numbers]] ||= count_arrangements(string, numbers)
    count += result
  end
  count
end

# p solve1(input) # 8193

def solve2(input)
  count = 0
  input.lines.each do |line|
    string, nums_raw = line.chomp.split
    numbers = nums_raw.split(',').map(&:to_i)
    unfolded_string = Array.new(5, string).join('?')
    unfolded_numbers = numbers * 5
    result = COMBINATIONS[[unfolded_string, unfolded_numbers]] ||= count_arrangements(unfolded_string, unfolded_numbers)
    count += result
  end
  count
end

# p solve2(input) # 45322533163795
