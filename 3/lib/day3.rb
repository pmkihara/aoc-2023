input = File.read(File.join(__dir__, './input.txt'))

def find_adjacent_numbers(row, position)
  adjacent_numbers = []
  row.scan(/\d+/) do |number,|
    num_i = $`.size
    num_range = num_i..(num_i + number.length - 1)
    if num_range.include?(position - 1) || num_range.include?(position) || num_range.include?(position + 1)
      adjacent_numbers << number.to_i
    end
  end
  adjacent_numbers
end

def solve1(input)
  rows = input.lines
  numbers = []
  rows.each_with_index do |row, row_i|
    row.chomp.to_enum(:scan, /[^(\w|\.|\d)]/).each do |symbol,|
      col_i = $`.size
      numbers << find_adjacent_numbers(rows[row_i - 1], col_i)
      numbers << find_adjacent_numbers(rows[row_i], col_i)
      numbers << find_adjacent_numbers(rows[row_i + 1], col_i)
    end
  end
  numbers.flatten.sum
end

def find_two_adjacent_numbers(rows, position)
  adjacent_numbers = []
  rows.each do |row|
    adjacent_numbers << find_adjacent_numbers(row, position)
  end
  adjacent_numbers.length > 1 ? adjacent_numbers : []
end

def solve2(input)
  rows = input.lines
  numbers = []
  rows.each_with_index do |row, row_i|
    row.chomp.to_enum(:scan, /[^(\w|\.|\d)]/).each do |symbol,|
      col_i = $`.size
      part_numbers = []
      part_numbers << find_adjacent_numbers(rows[row_i - 1], col_i)
      part_numbers << find_adjacent_numbers(rows[row_i], col_i)
      part_numbers << find_adjacent_numbers(rows[row_i + 1], col_i)
      part_numbers.flatten!
      numbers << part_numbers.reduce(:*) if part_numbers.length > 1
    end
  end
  numbers.flatten.sum
end

# p solve1(input) # 526404
# p solve2(input) # 84399773
