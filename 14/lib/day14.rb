# frozen_string_literal: true

require 'pry-byebug'
input = File.read(File.join(__dir__, './input.txt'))
example = File.read(File.join(__dir__, './example.txt'))

def tilt_north(matrix)
  tilted = matrix.transpose.map.with_index do |col, col_i|
    col.join.gsub(/([O.]+)/) { |match| match.chars.sort.reverse.join }.chars
  end
  tilted.transpose
end

def tilt_south(matrix)
  tilted = matrix.transpose.map.with_index do |col, col_i|
    col.join.gsub(/([O.]+)/) { |match| match.chars.sort.join }.chars
  end
  tilted.transpose
end

def tilt_west(matrix)
  matrix.map.with_index do |row, row_i|
    tilted_row = row.join.gsub(/([O.]+)/) { |match| match.chars.sort.reverse.join }.chars
    matrix[row_i] = tilted_row
  end
end

def tilt_east(matrix)
  matrix.map.with_index do |row, row_i|
    tilted_row = row.join.gsub(/([O.]+)/) { |match| match.chars.sort.join }.chars
    matrix[row_i] = tilted_row
  end
end

def tilt_all(matrix)
  tilted = tilt_north(matrix)
  tilted = tilt_west(tilted)
  tilted = tilt_south(tilted)
  tilt_east(tilted)
end

def cycle(matrix, times)
  times.times do |i|
    if !TILTS[matrix]
      TILTS[matrix] = 0
    elsif TILTS[matrix].zero?
      TILTS[matrix] = i
    elsif TILTS[matrix]
      return { index: i, min: TILTS.values.reject(&:zero?).min, max: TILTS.values.max }
    end
    matrix = tilt_all(matrix)
  end
end

def calculate_total(matrix, total_rows)
  total = 0
  matrix.each_with_index do |row, row_i|
    row.each do |col|
      total += (total_rows - row_i) if col == 'O'
    end
  end
  total
end

def solve1(input)
  matrix = input.lines.map { |line| line.chomp.chars }
  tilted = tilt_north(matrix)
  calculate_total(tilted, input.lines.length)
end

TILTS = {}

def solve2(input)
  matrix = input.lines.map { |line| line.chomp.chars }
  cycle_info = cycle(matrix, 1000000000)
  position = ((1000000000 - cycle_info[:min]) % (cycle_info[:max] - cycle_info[:min] + 1)) + cycle_info[:min]
  calculate_total(TILTS.key(position), input.lines.length)
end

# p solve1(input) # => 106517
# p solve2(input) # => 79723
