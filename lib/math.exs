defmodule Math do
  def sum(a, b) do
    do_sum(a, b)
  end

  # Private function
  defp do_sum(a, b) do
    a + b
  end

  # Pattern matching
  def zero?(0), do: true
  def zero?(x) when is_number(x), do: false

  # Recursion
  def sum_list([head|tail], acc) do
    sum_list(tail, head+acc)
  end

  def sum_list([], acc) do
    acc
  end

  def double_each([head|tail]) do
    [head * 2 | double_each(tail)]
  end

  def double_each([]) do
    []
  end
end

IO.puts Math.sum_list([1,2,3], 0)
IO.puts Math.double_each([1,2,3])
