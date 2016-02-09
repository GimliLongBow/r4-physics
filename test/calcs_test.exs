defmodule CalcsTest do
  use ExUnit.Case
  doctest Calcs

  test "to_nearest_tenth rounds up always" do
    assert Calcs.to_nearest_tenth(5.21) == 5.3
  end

  test "to_nearest_tenth ignores at .00" do
    assert Calcs.to_nearest_tenth(5.20) == 5.2
  end

  test "to_nearest_hundredth rounds up to nearest hundreth" do
    assert Calcs.to_nearest_hundredth(5.201) == 5.21
  end

  test "to_km converts meters to kilomters" do
    assert Calcs.to_km(1000) == 1
  end

  test "to_m converts kilometers to meters" do
    assert Calcs.to_m(2) == 2000
  end

  test "square_root returns the square root of a number" do
    assert Calcs.square_root(4) == 2
  end

  test "cube_root returns the cube root of a number" do
    assert Calcs.cube_root(8) == 2
  end

  test "squared returns the square of a number" do
    assert Calcs.squared(2) == 4
  end

  test "cubed returns the cube of a number" do
    assert Calcs.cubed(2) == 8
  end

  test "seconds_to_hours" do
    assert Calcs.seconds_to_hours(18000) == 5
  end

  test "hours_to_seconds" do
    assert Calcs.hours_to_seconds(5) == 18000
  end

  test "nth_root returns the nth root" do
    assert Calcs.nth_root(3, 8) == 2
  end

  test "nth_root returns the best guess for nth root" do
    assert Calcs.nth_root(3, 12) == 2.2894284851118587
  end

end
