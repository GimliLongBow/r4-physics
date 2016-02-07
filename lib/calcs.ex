defmodule Calcs do
  def to_nearest_tenth(val) do
    Float.ceil(val, 1)
  end

  def to_nearest_hundredth(val) do
    Float.ceil(val, 2)
  end

  def to_km(meters) do
    meters / 1000
  end

  def to_m(kilometers) do
    kilometers * 1000
  end

  def square_root(val) do
    :math.sqrt(val)
  end

  def cube_root(val) do
    nth_root(3, val)
  end

  def squared(val) do
    val * val
  end

  def cubed(val) do
    val * val * val
  end

  def seconds_to_hours(seconds) do
    seconds / 60 / 60
  end

  def nth_root(n, x, precision \\ 1.0e-5) do
    f = fn(prev) -> ((n - 1) * prev + x / :math.pow(prev, (n-1))) / n end
    fixed_point(f, x, precision, f.(x))
  end

  defp fixed_point(_, guess, tolerance, next) when abs(guess - next) < tolerance, do: next
  defp fixed_point(f, _, tolerance, next), do: fixed_point(f, next, tolerance, f.(next))
end
