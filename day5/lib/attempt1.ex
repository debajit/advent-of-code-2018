# Suboptimal --- Too slow. See Day1.Part1 for an improved solution in O(n) time.
defmodule Day5.Attempt1 do
  @doc """
      iex> reduce("dabAcCaCBAcCcaDA")
      "dabCBAcaDA"
  """

  def reduce(string) when is_binary(string) do
    string
    |> String.reverse()
    |> String.codepoints()
    |> reduce([], false)
    |> Enum.join()
    |> IO.inspect()
  end

  def reduce([a | [b | tail]], acc, removed) do
    if a == String.downcase(b) or a == String.upcase(b) do
      reduce(tail, acc, true)
    else
      reduce([b | tail], [a | acc], removed || false)
    end
  end

  def reduce([a], acc, removed) do
    reduce([], [a | acc], removed)
  end

  def reduce([], acc, true) do
    reduce(acc, [], false)
  end

  def reduce([], acc, false) do
    acc
  end
end
