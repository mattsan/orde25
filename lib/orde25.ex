defmodule Orde25 do
  def solve(input) do
    [width, height, x, y] =
      input
      |> String.split(~r/[,)(]+/, trim: true)
      |> Enum.map(&String.to_integer/1)

    sevens =
      for dx <- -x..(width - x - 1), dy <- -y..(height - y - 1) do
        [
          {x, y},
          {x + dx, y - dy},
          {x + dx + dy, y - dy + dx},
          {x + dy - dx, y + dx + dy}
        ]
      end
      |> Enum.filter(&Enum.all?(&1, fn {x, y} -> 0 <= x && x < width && 0 <= y && y < height end))
      |> Enum.map(&append_length/1)

    max_length = sevens |> Enum.map(&elem(&1, 0)) |> Enum.max()

    case sevens |> Enum.filter(fn {length, _} -> length == max_length end) do
      [{^max_length, [{^x, ^y}, {x2, y2}, {x3, y3}, {x4, y4}]}] when {x, y} != {x2, y2} ->
        "(#{x2},#{y2}),(#{x3},#{y3}),(#{x4},#{y4})"

      _ ->
        "-"
    end
  end

  def append_length([{x1, y1}, {x2, y2} | _] = data) do
    {
      (x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1),
      data
    }
  end
end
