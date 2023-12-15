# frozen_string_literal: true

require 'pry-byebug'
require 'matrix'
input = File.read(File.join(__dir__, './input.txt'))

def smudge?(part_a, part_b)
  diff_count = 0
  part_a.reverse.zip(part_b).each do |(a, b)|
    a.each_with_index do |elem, i|
      diff_count += 1 unless b[i] == elem
    end
  end
  diff_count == 1
end

def reflection_pattern?(part_a, part_b, find_smudge)
  # Ignore extra lines (when the parts don't have the same size)
  size_diff = part_a.length - part_b.length
  part_a = part_a[size_diff..] if size_diff.positive? # when left is bigger then right

  if find_smudge
    smudge?(part_a, part_b)
  else
    part_a.reverse == part_b
  end
end

def find_reflection(matrix, rows, columns, find_smudge = false, direction = 'row', index = 1)
  case direction
  when 'row'
    part_a = rows[0...index]
    part_b = rows[index...(index * 2)]
  when 'column'
    part_a = columns[0...index]
    part_b = columns[index...(index * 2)]
  end

  return { index: index, direction: direction } if reflection_pattern?(part_a, part_b, find_smudge)

  index += 1
  if direction == 'row' && index == matrix.row_count
    direction = 'column'
    index = 1
  end

  find_reflection(matrix, rows, columns, find_smudge, direction, index)
end

def solve1(input)
  patterns = input.split("\n\n")
  nums = patterns.map do |line|
    matrix = Matrix.rows(line.split("\n").map(&:chars))
    result = find_reflection(matrix, matrix.row_vectors, matrix.column_vectors)
    result[:direction] == 'column' ? result[:index] : result[:index] * 100
  end
  nums.sum
end

def solve2(input)
  patterns = input.split("\n\n")
  nums = patterns.map do |line|
    matrix = Matrix.rows(line.split("\n").map(&:chars))
    result = find_reflection(matrix, matrix.row_vectors, matrix.column_vectors, true)
    result[:direction] == 'column' ? result[:index] : result[:index] * 100
  end
  nums.sum
end

# p solve1(input) # 31265
# p solve2(input) # 39359
