defmodule InventoryManagementSystem do
  @moduledoc """
  Solution to Advent of Code puzzle for Day 2 (Part 2)
  https://adventofcode.com/2018/day/2

  The solution essentially boils down to this:
  - Given a list of words, we need to
  - Compare each pair of words together (O(n^2) “loop”)
  - Find the first pair that differ by one character (Enum.find_value operation in Elixir)
  - Return the common letters
  """

  def find_common_substring(ids) do
    for i <- ids, j <- ids, i != j do
      {i, j}
    end
    |> Enum.find_value(fn {x, y} ->
      find_common_letters_if_strings_differ_by_one_char(x, y)
    end)
  end

  # Returns the common letters between two strings if they differ by
  # one letter only. Returns nil otherwise.
  defp find_common_letters_if_strings_differ_by_one_char(string1, string2) do
    case String.myers_difference(string1, string2) do
      [eq: match1, del: <<_>>, ins: <<_>>, eq: match2] ->
        match1 <> match2

      _ ->
        nil
    end
  end
end

[input_file] = System.argv()

File.read!(input_file)
|> String.split("\n", trim: true)
|> InventoryManagementSystem.find_common_substring()
|> IO.inspect()
