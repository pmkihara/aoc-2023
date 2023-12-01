input = File.read(File.join(__dir__, './input.txt'))

NUMBERS = {
  'one'   => 1,
  'two'   => 2,
  'three' => 3,
  'four'  => 4,
  'five'  => 5,
  'six'   => 6,
  'seven' => 7,
  'eight' => 8,
  'nine'  => 9,
}

def simple_parse(string)
  matches = string.scan(/\d/)
  "#{matches.first}#{matches.last}".to_i
end

def solve1(input)
  input.lines.map { |line| simple_parse(line.chomp.downcase) }.sum
end

def improved_parse(string)
  first_digit = string[Regexp.new(NUMBERS.keys.push('\d').join('|'))]
  last_digit = string.reverse[Regexp.new(NUMBERS.keys.map(&:reverse).push('\d').join('|'))].reverse
  "#{NUMBERS[first_digit] || first_digit}#{NUMBERS[last_digit] || last_digit}".to_i
end

def solve2(input)
  input.lines.map { |line| improved_parse(line.chomp.downcase) }.sum
end

puts solve1(input) # 54597
puts solve2(input) # 54504
