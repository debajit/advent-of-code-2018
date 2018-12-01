defmodule ChronalCalibration do
  @moduledoc """
  Solution to Advent of Code puzzle for Day 1 (Part 1)
  https://adventofcode.com/2018/day/1
  """

  def find_frequency(input_file) do
    File.stream!(input_file)
    |> Stream.map(&String.trim/1)
    |> Stream.map(&String.to_integer/1)
    |> Enum.sum
  end
end

[input_file] = System.argv
IO.inspect ChronalCalibration.find_frequency(input_file)
