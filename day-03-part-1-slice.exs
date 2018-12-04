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

defmodule NoMatterHowYouSliceIt do
  @moduledoc """
  Solution to Advent of Code puzzle for Day 3 (Part 1)
  https://adventofcode.com/2018/day/3

  There are a couple of things here:

  - Parsing each line (Using regex named captures solves this easily)

  - How to represent a matrix. (We can do this with a sparse
    representation using a map whose key is the {row, col} pair, and
    whose value is anything, say 1. This took me a surprisingly long
    while to figure out. Initially I tried using the Tensor.Matrix
    library for this)

  - For each claim, we find the sparse matrix and we can merge these
    sparse maps together. In the case when the cell already exists, we
    simply update the number. Counting the number of non-default cell
    values gives us the overlay area.
  """

  # Merges the sparse maps. If the same “cell” is merged, the keys (1
  # by default) are added. We count the keys that not 1 to find the overlay area.
  def overlay_area(input_stream) do
    input_stream
    |> Stream.map(&Claim.from_string/1)
    |> Stream.map(&coords_map/1)
    |> Enum.reduce(%{}, fn map, acc ->
      Map.merge(map, acc, fn _k, v1, v2 ->
        v1 + v2
      end)
    end)
    |> Enum.count(fn {_k, v} -> v != 1 end)
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

[input_file] = System.argv()

File.stream!(input_file)
|> NoMatterHowYouSliceIt.overlay_area()
|> IO.inspect()
