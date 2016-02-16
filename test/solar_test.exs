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
    assert Solar.power(hd(flares)) == 99000
  end

  test "power for an M class flare is 10", %{data: flares} do
    assert Solar.power(Enum.at(flares, 1)) == 58
  end

  test "power for a C class flare is 1", %{data: flares} do
    assert Solar.power(Enum.at(flares, 3)) == 3.2
  end

  test "no_eva returns only flares with a power < 1000", %{data: flares}  do
    Enum.each Solar.no_eva(flares), &(assert(Solar.power(&1)) < 1000)
  end

  test "no_eva returns three flares < 1000", %{data: flares} do
    assert length(Solar.no_eva(flares)) == 3
  end

  test "deadliest flare", %{data: flares} do
    assert Solar.deadliest(flares) == 99000
  end

  test "total flare power", %{data: flares} do
    assert Solar.total_flare_power(flares) == 216911.7
  end

end
