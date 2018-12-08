defmodule Day5.Part1 do
  @moduledoc """
  Solution to Advent of Code puzzle for Day 5 (Part 1)
  https://adventofcode.com/2018/day/5
  """

  @doc """
      iex> reduce("dabAcCaCBAcCcaDA")
      "dabCBAcaDA"
  """
  def reduce(polymer) when is_binary(polymer),
    do: reduce(polymer, [])

  defp reduce(<<letter1, rest::binary>>, [letter2 | acc]) when abs(letter1 - letter2) == 32,
    do: reduce(rest, acc)

  defp reduce(<<letter, rest::binary>>, acc),
    do: reduce(rest, [letter | acc])

  defp reduce(<<>>, acc),
    do: acc |> Enum.reverse() |> List.to_string()

  # reduce("dabAcCaCBAcCcaDA", [])
  # reduce("abAcCaCBAcCcaDA", [?d])
  # reduce("bAcCaCBAcCcaDA", [?a, ?d])
  # reduce("AcCaCBAcCcaDA", [?b, ?a, ?d])
  # reduce("cCaCBAcCcaDA", [?A, ?b, ?a, ?d])
  # reduce("CaCBAcCcaDA", [?c, ?A, ?b, ?a, ?d])
  # reduce("aCBAcCcaDA", [?A, ?b, ?a, ?d])
  # reduce("CBAcCcaDA", [?b, ?a, ?d])
end
