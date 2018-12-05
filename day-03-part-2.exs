defmodule Claim do
  defstruct [:id, :left, :top, :width, :height]

  @claim_regex ~r/^\#(?<id>\d+) @ (?<left>\d+),(?<top>\d+): (?<width>\d+)x(?<height>\d+)$/

  def from_string(claim_string) do
    %{"id" => id, "left" => left, "top" => top, "width" => width, "height" => height} =
      Regex.named_captures(@claim_regex, claim_string)

    %Claim{
      id: String.to_integer(id),
      left: String.to_integer(left),
      top: String.to_integer(top),
      width: String.to_integer(width),
      height: String.to_integer(height)
    }
  end
end

defmodule Day3.Part2 do
  @moduledoc """
  Solution to Advent of Code puzzle for Day 3 (Part 2)
  https://adventofcode.com/2018/day/3

  “What is the ID of the only claim that doesn't overlap?”

  We need to find the first claim (a “find” operation in fp) that
  returns true for a function that checks if all the cells in the
  sparse matrix are 1.
  """

  def non_overlapping_rect(input) do
    claims =
      input
      |> Enum.map(&Claim.from_string/1)

    matrix =
      claims
      |> Enum.map(&coords_map/1)
      |> Enum.reduce(%{}, fn map, acc ->
        Map.merge(map, acc, fn _k, v1, v2 ->
          v1 + v2
        end)
      end)

    %Claim{id: id} =
      Enum.find(claims, fn claim ->
        Enum.all?(coords(claim), fn coord ->
          matrix[coord] == 1
        end)
      end)

    id
  end

  def coords(%Claim{left: left, top: top, width: width, height: height}) do
    for r <- top..(top + height - 1),
        c <- left..(left + width - 1) do
      {r, c}
    end
  end

  # Sparse “matrix” representation for the claim, using a map. Each
  # entry is of type {row, col} => 1
  defp coords_map(%Claim{left: left, top: top, width: width, height: height}) do
    for r <- top..(top + height - 1),
        c <- left..(left + width - 1) do
      {{r, c}, 1}
    end
    |> Map.new()
  end
end

# [
#   "#1 @ 1,3: 4x4",
#   "#2 @ 3,1: 4x4",
#   "#3 @ 5,5: 2x2"
# ]
# |> Day3.Part2.non_overlapping_rect()
# |> IO.inspect()

[input_file] = System.argv()

File.stream!(input_file)
|> Day3.Part2.non_overlapping_rect()
|> IO.inspect()
