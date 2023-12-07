# frozen_string_literal: true

require 'pry-byebug'
input = File.read(File.join(__dir__, './input.txt'))

def calculate_distance(press, time)
  press * (time - press)
end

def find_wins(time, record)
  wins_center = time / 2
  wins_start = nil

  (1..time).each do |press|
    break if wins_start

    travel_distance = calculate_distance(press, time)
    wins_start = press if travel_distance > record
  end

  wins_end = wins_center + (wins_center - wins_start)
  wins_end += 1 if time.odd?
  wins_end - wins_start + 1
end

def solve1(input)
  times, records = input.lines.map { |line| line.scan(/\d+/) }
  wins = []

  times.each_with_index do |time_string, index|
    time = time_string.to_i
    record = records[index].to_i
    wins << find_wins(time, record)
  end
  wins.reduce(:*)
end

# p solve1(input) # => 633080

def solve2(input)
  time_raw, record_raw = input.lines.map { |line| line.scan(/\d+/) }
  time = time_raw.join.to_i
  record = record_raw.join.to_i
  find_wins(time, record)
end

p solve2(input) # => 20048741
