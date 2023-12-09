# frozen_string_literal: true

require 'pry-byebug'
input = File.read(File.join(__dir__, './input.txt'))

def diff_sequence(numbers)
  sequence = []
  numbers.each_cons(2) { |pair| sequence << pair.last - pair.first }
  sequence
end

def sequences(numbers, sequences = [numbers])
  sequences << diff_sequence(sequences.last) until sequences.last.all?(&:zero?)
  sequences
end

def next_number(sequences)
  diff = 0
  sequences.reverse.each { |sequence| diff = sequence.last + diff }
  diff
end

def solve1(input)
  next_values = input.lines.map do |line|
    numbers = line.chomp.split.map(&:to_i)
    sequences = sequences(numbers)
    next_number(sequences)
  end
  next_values.reduce(:+)
end

# p solve1(input) # => 1834108701

def previous_number(sequences)
  diff = 0
  sequences.reverse.each { |sequence| diff = sequence.first - diff }
  diff
end

def solve2(input)
  previous_values = input.lines.map do |line|
    numbers = line.chomp.split.map(&:to_i)
    sequences = sequences(numbers)
    previous_number(sequences)
  end
  previous_values.reduce(:+)
end

# p solve2(input) # => 993
