defmodule Day5.Part2 do
  @moduledoc """
  Solution to Advent of Code puzzle for Day 5 (Part 2)
  https://adventofcode.com/2018/day/5
  """

  @doc """
      iex> discard_and_reduce("dabAcCaCBAcCcaDA", ?A, ?a)
      "dbCBcD"
  """
  def discard_and_reduce(polymer, discard1, discard2)
      when is_binary(polymer),
      do: discard_and_reduce(polymer, [], discard1, discard2)

  defp discard_and_reduce(<<letter, rest::binary>>, acc, discard1, discard2)
       when letter == discard1
       when letter == discard2,
       do: discard_and_reduce(rest, acc, discard1, discard2)

  defp discard_and_reduce(<<letter1, rest::binary>>, [letter2 | acc], discard1, discard2)
       when abs(letter1 - letter2) == 32,
       do: discard_and_reduce(rest, acc, discard1, discard2)

  defp discard_and_reduce(<<letter, rest::binary>>, acc, discard1, discard2),
    do: discard_and_reduce(rest, [letter | acc], discard1, discard2)

  defp discard_and_reduce(<<>>, acc, _discard1, _discard2),
    do: acc |> Enum.reverse() |> List.to_string()

  # discard_and_reduce("dabAcCaCBAcCcaDA", [])
  # discard_and_reduce("abAcCaCBAcCcaDA", [?d])
  # discard_and_reduce("bAcCaCBAcCcaDA", [?a, ?d])
  # discard_and_reduce("AcCaCBAcCcaDA", [?b, ?a, ?d])
  # discard_and_reduce("cCaCBAcCcaDA", [?A, ?b, ?a, ?d])
  # discard_and_reduce("CaCBAcCcaDA", [?c, ?A, ?b, ?a, ?d])
  # discard_and_reduce("aCBAcCcaDA", [?A, ?b, ?a, ?d])
  # discard_and_reduce("CBAcCcaDA", [?b, ?a, ?d])

  @doc """
      iex> find_problematic_unit("dabAcCaCBAcCcaDA")
      4
  """
  def find_problematic_unit(polymer) do
    ?a..?z
    |> Enum.map(&discard_and_reduce(polymer, &1, &1 - 32))
    |> Enum.map(&byte_size/1)
    |> Enum.min()
  end

  @doc """
      iex> find_problematic_unit_parallel("dabAcCaCBAcCcaDA")
      4
  """
  def find_problematic_unit_parallel(polymer) do
    ?a..?z
    |> Task.async_stream(fn letter ->
      discard_and_reduce(polymer, letter, letter - 32)
      |> byte_size
    end)
    |> Stream.map(fn {:ok, x} -> x end)
    |> Enum.min()
  end
end
