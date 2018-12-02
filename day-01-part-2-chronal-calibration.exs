defmodule ChronalCalibration do
  @moduledoc """
  Solution to Advent of Code puzzle for Day 1 (Part 2)
  https://adventofcode.com/2018/day/1
  """

  def first_repeated_frequency(input_file) do
    File.stream!(input_file)
    |> Stream.cycle()
    |> Stream.map(&String.trim/1)
    |> Stream.map(&String.to_integer/1)
    |> Enum.reduce_while({0, MapSet.new()}, fn x, {sum, seen} ->
      if MapSet.member?(seen, sum) do
        {:halt, {sum, seen}}
      else
        {:cont, {x + sum, MapSet.put(seen, sum)}}
      end
    end)
    |> elem(0)
  end
end

[input_file] = System.argv()
IO.inspect ChronalCalibration.first_repeated_frequency(input_file)
