defmodule SolarTest do
  use ExUnit.Case
  use Timex
  import Solar.Flare

  setup do
    flares = [
      %Solar.Flare{classification: :X, scale: 99, date: Date.from({1859, 8, 29})},
      %Solar.Flare{classification: :M, scale: 5.8, date: Date.from({2015, 1, 12})},
      %Solar.Flare{classification: :M, scale: 1.2, date: Date.from({2015, 2, 9})},
      %Solar.Flare{classification: :C, scale: 3.2, date: Date.from({2015, 4, 18})},
      %Solar.Flare{classification: :M, scale: 83.6, date: Date.from({2015, 6, 23})},
      %Solar.Flare{classification: :C, scale: 2.5, date: Date.from({2015, 7, 4})},
      %Solar.Flare{classification: :X, scale: 72, date: Date.from({2012, 7, 23})},
      %Solar.Flare{classification: :X, scale: 45, date: Date.from({2003, 11, 4})},
    ]
    {:ok, data: flares}
  end

  test "We have 8 solar flares", %{data: flares} do
    assert length(flares) == 8
  end

  test "calculate_power for an X class flare is 1000", %{data: flares} do
    assert Map.get(calculate_power(hd(flares)), :power) == 99000
  end

  test "calculate_power for an M class flare is 10", %{data: flares} do
    assert calculate_power(Enum.at(flares, 1)).power == 58
  end

  test "calculate_power for a C class flare is 1", %{data: flares} do
    assert calculate_power(Enum.at(flares, 3)).power == 3.2
  end

  test "no_eva returns only flares with a calculate_power < 1000", %{data: flares}  do
    Enum.each no_eva(flares), &(assert(calculate_power(&1)) < 1000)
  end

  test "no_eva returns three flares < 1000", %{data: flares} do
    assert length(no_eva(flares)) == 3
  end

  test "deadliest flare", %{data: flares} do
    assert deadliest(flares) == 99000
  end

  test "total flare calculate_power", %{data: flares} do
    assert total_flare_power(flares) == 216911.7
  end

  test "deadly flares", %{data: flares} do
    #IO.puts flare_list(flares)
    Enum.each flare_list(flares), &( if (&1[:calculate_power] > 1000), do: assert &1[:is_deadly ] == true)
  end

  test "load flares with is_deadly property", %{data: flares} do
    assert Map.get(hd(load(flares)), :is_deadly) == true
  end

  test "load flares with calculate_power property", %{data: flares} do
    flare = hd(load(flares))
    assert flare.power == 99000
  end

end
