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
    :math.pow(val, 1/3)
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

  def hours_to_seconds(hours) do
    hours * 60 * 60
  end
end
