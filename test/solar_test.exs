defmodule SolarTest do
  use ExUnit.Case
  use Timex

  setup do
    flares = [
      %{classification: :X, scale: 99, date: Date.from({1859, 8, 29})},
      %{classification: :M, scale: 5.8, date: Date.from({2015, 1, 12})},
      %{classification: :M, scale: 1.2, date: Date.from({2015, 2, 9})},
      %{classification: :C, scale: 3.2, date: Date.from({2015, 4, 18})},
      %{classification: :M, scale: 83.6, date: Date.from({2015, 6, 23})},
      %{classification: :C, scale: 2.5, date: Date.from({2015, 7, 4})},
      %{classification: :X, scale: 72, date: Date.from({2012, 7, 23})},
      %{classification: :X, scale: 45, date: Date.from({2003, 11, 4})},
    ]
    {:ok, data: flares}
  end

  test "We have 8 solar flares", %{data: flares} do
    assert length(flares) == 8
  end

  test "power for an X class flare is 1000", %{data: flares} do
    assert Solar.Flares.power(hd(flares)) == 99000
  end

  test "power for an M class flare is 10", %{data: flares} do
    assert Solar.Flares.power(Enum.at(flares, 1)) == 58
  end

  test "power for a C class flare is 1", %{data: flares} do
    assert Solar.Flares.power(Enum.at(flares, 3)) == 3.2
  end

  test "no_eva returns only flares with a power < 1000", %{data: flares}  do
    Enum.each Solar.Flares.no_eva(flares), &(assert(Solar.Flares.power(&1)) < 1000)
  end

  test "no_eva returns three flares < 1000", %{data: flares} do
    assert length(Solar.Flares.no_eva(flares)) == 3
  end

  test "deadliest flare", %{data: flares} do
    assert Solar.Flares.deadliest(flares) == 99000
  end

  test "total flare power", %{data: flares} do
    assert Solar.Flares.total_flare_power(flares) == 216911.7
  end

  test "deadly flares", %{data: flares} do
    #IO.puts Solar.Flares.flare_list(flares)
    Enum.each Solar.Flares.flare_list(flares), &( if (&1[:power] > 1000), do: assert &1[:is_deadly ] == true)
  end

end
