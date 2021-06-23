defmodule BinaryCounter.V1 do
  @moduledoc false

  def nonogramrow(), do: []
  def nonogramrow(input), do: count(input)

  defp count([]), do: []
  defp count(list), do: do_count(list, [0, []])

  defp do_count([], [0, result]), do: result
  defp do_count([], [0, []]), do: []

  defp do_count([], [counter, result]),
    do: result ++ [counter]

  defp do_count([head | tail], [counter, result]) when head == 1,
    do: do_count(tail, [counter + 1, result])

  defp do_count([head | tail], [counter, result]) when head == 0 and counter == 0,
    do: do_count(tail, [counter, result])

  defp do_count([head | tail], [counter, result]) when head == 0 and counter != 0,
    do: do_count(tail, [0, result ++ [counter]])
end

defmodule BinaryCounter.V2 do
  @moduledoc false

  def nonogramrow(), do: []
  def nonogramrow(input), do: count(input)

  defp count([]), do: []
  defp count(list), do: do_count(list, [0, []])

  defp do_count([], [0, result]), do: result |> Enum.reverse()
  defp do_count([], [0, []]), do: []

  defp do_count([], [counter, result]),
    do: [counter | result] |> Enum.reverse()

  defp do_count([1 | tail], [counter, result]),
    do: do_count(tail, [counter + 1, result])

  defp do_count([0 | tail], [0, result]),
    do: do_count(tail, [0, result])

  defp do_count([0 | tail], [counter, result]),
    do: do_count(tail, [0, [counter | result]])
end

case System.argv() do
  ["--test"] ->
    ExUnit.start()

    defmodule BinaryCounterTest do
      use ExUnit.Case

      test "V1" do
        assert BinaryCounter.V1.nonogramrow() == []
        assert BinaryCounter.V1.nonogramrow([]) == []
        assert BinaryCounter.V1.nonogramrow([0, 0, 0, 0, 0]) == []
        assert BinaryCounter.V1.nonogramrow([1, 1, 1, 1, 1]) == [5]
        assert BinaryCounter.V1.nonogramrow([0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1]) == [5, 4]
        assert BinaryCounter.V1.nonogramrow([1, 1, 0, 1, 0, 0, 1, 1, 1, 0, 0]) == [2, 1, 3]
        assert BinaryCounter.V1.nonogramrow([0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 1]) == [2, 1, 3]

        assert BinaryCounter.V1.nonogramrow([1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1]) == [
                 1,
                 1,
                 1,
                 1,
                 1,
                 1,
                 1,
                 1
               ]
      end

      test "V2" do
        assert BinaryCounter.V2.nonogramrow() == []
        assert BinaryCounter.V2.nonogramrow([]) == []
        assert BinaryCounter.V2.nonogramrow([0, 0, 0, 0, 0]) == []
        assert BinaryCounter.V2.nonogramrow([1, 1, 1, 1, 1]) == [5]
        assert BinaryCounter.V2.nonogramrow([0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1]) == [5, 4]
        assert BinaryCounter.V2.nonogramrow([1, 1, 0, 1, 0, 0, 1, 1, 1, 0, 0]) == [2, 1, 3]
        assert BinaryCounter.V2.nonogramrow([0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 1]) == [2, 1, 3]

        assert BinaryCounter.V2.nonogramrow([1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1]) == [
                 1,
                 1,
                 1,
                 1,
                 1,
                 1,
                 1,
                 1
               ]
      end
    end

  _ ->
    IO.puts(:stderr, "\nplease specify --test")
end
