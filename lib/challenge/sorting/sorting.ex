defmodule Challenge.Sorting do
  defp random_pos(list) when length(list) > 1, do: :rand.uniform(length(list)) - 1
  defp random_pos(_), do: 0

  def sort([]), do: []
  def sort([unique]), do: [unique]
  def sort([n, m]) do
    cond do
      n < m -> [n, m]
      n > m -> [m, n]
    end
  end
  def sort(list) do
    {pivot1, first_rest} = List.pop_at(list, random_pos(list))
    {pivot2, rest} = List.pop_at(first_rest, random_pos(first_rest))

    l_pivot = Enum.min([pivot1, pivot2])
    h_pivot = Enum.max([pivot1, pivot2])

    sort(for x <- rest, x < l_pivot, do: x)
      ++[l_pivot]++
    sort(for x <- rest, x >= l_pivot, x < h_pivot, do: x)
      ++[h_pivot]++
    sort(for x <- rest, x >= h_pivot, do: x)
  end
end
