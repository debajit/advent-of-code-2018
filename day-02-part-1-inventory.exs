defmodule InventoryManagementSystem do
  @moduledoc """
  Solution to Advent of Code puzzle for Day 2 (Part 1)
  https://adventofcode.com/2018/day/2
  """

  def checksum(input_file) do
    {freq2, freq3} =
      File.stream!(input_file)
      |> Stream.map(&freq_char_map/1)
      |> Stream.flat_map(&Map.keys/1)
      |> Enum.reduce({0, 0}, fn x, {count2, count3} ->
        if x == 2 do
          {count2 + 1, count3}
        else
          {count2, count3 + 1}
        end
      end)

    freq2 * freq3
  end

  defp freq_char_map(id) do
    # e.g. %{"a" => 2, "b" => 3, "c" => 1}
    char_freq_map =
      id
      |> String.codepoints()
      |> Enum.reduce(%{}, fn x, acc -> Map.update(acc, x, 1, &(&1 + 1)) end)

    # Flip the char-frequency map into a frequency-char map with only 2 and 3 as keys:
    for {char, freq} <- char_freq_map, freq == 2 or freq == 3, into: %{}, do: {freq, char}
  end
end

[input_file] = System.argv()
IO.inspect InventoryManagementSystem.checksum(input_file)
