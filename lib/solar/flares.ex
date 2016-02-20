defmodule Solar.Flares do

  def power(%{classification: :X, scale: s}), do: s * 1000
  def power(%{classification: :M, scale: s}), do: s * 10
  def power(%{classification: :C, scale: s}), do: s * 1

  def no_eva(flares) do
    Enum.filter flares, fn(flare) -> power(flare) > 1000 end
  end

  def deadliest(flares) do
    Enum.map(flares, &(power(&1)))
      |> Enum.max
  end

  def total_flare_power(flares) do
    Enum.map(flares, &(power(&1)))
      |> Enum.sum
  end

  def flare_list(flares) do
    for flare <- flares, flare.classification === :X, do: %{power: power(flare), is_deadly: power(flare) > 1000}
  end
end
