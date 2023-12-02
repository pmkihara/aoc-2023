input = File.read(File.join(__dir__, './input.txt'))

def max_cubes(string)
  game, cubes = string.split(': ')
  cubes_total = Hash.new(0)
  cubes.split(/, |; /).each do |cube|
    cube_count, cube_color = cube.split
    cubes_total[cube_color] = cube_count.to_i if cube_count.to_i > cubes_total[cube_color]
  end
  cubes_total['game'] = game[/\d+/].to_i
  cubes_total
end

def enough_cubes?(cubes_total)
  bag = {
    'red' => 12,
    'green'=> 13,
    'blue' => 14
  }
  bag.all? { |k, v|
    v >= cubes_total[k]
  }
end

def solve1(input)
  sum = 0
  input.lines.each do |line|
    cubes_total = max_cubes(line)
    sum += cubes_total['game'] if enough_cubes?(cubes_total)
  end
  sum
end

def cubes_power(cubes_total)
  cubes_total.except('game').values.reduce(:*)
end

def solve2(input)
  total_power = 0
  input.lines.each do |line|
    cubes_total = max_cubes(line)
    total_power += cubes_power(cubes_total)
  end
  total_power
end

# puts solve1(input) # 2679
puts solve2(input) # 77607
