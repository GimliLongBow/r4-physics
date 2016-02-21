defmodule Solar.Flare do

  defstruct [
    classification: :M,
    scale: 0,
    power: 0,
    is_deadly: false,
    date: nil
  ]

  def load(flares) do
    for flare <- flares, do:
      flare
        |> calculate_power
        |> calculate_deadliness
  end

  def calculate_power(flare) do
    factor = case flare.classification do
      :X -> 1000
      :M -> 10
      :C -> 1
    end
    %{flare | power: flare.scale * factor}
  end

  def calculate_deadliness(flare) do
    %{flare | is_deadly: flare.power > 1000}
  end

  def no_eva(flares) do
    Enum.filter flares, fn(flare) -> calculate_power(flare).power > 1000 end
  end

  def deadliest(flares) do
    Enum.map(flares, &(calculate_power(&1).power))
      |> Enum.max
  end

  def total_flare_power(flares) do
    Enum.map(flares, &(calculate_power(&1).power))
      |> Enum.sum
  end

  def flare_list(flares) do
    for flare <- flares, flare.classification === :X, do: %{calculate_power: calculate_power(flare), is_deadly: calculate_power(flare) > 1000}
  end
end
