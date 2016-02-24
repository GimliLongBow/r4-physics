defmodule RocketryTest do
  use ExUnit.Case
  doctest Physics
  import Physics.Rocketry

  # Orbital Speed

  test "orbital_speed for a given planet and height in kilometers" do
    os = orbital_speed(PlanetList.select[:earth], 100)
    assert os == 7846.404191259335
  end

  test "orbital_speed defaults to Earth" do
    os = orbital_speed(100)
    assert os == 7846.404191259335
  end

  # Orbital Acceleration

  test "orbital acceleration for Earth at 100km" do
    oa = orbital_acceleration(PlanetList.select[:earth], 100)
    assert oa == 9.52
  end

  test "orbital acceleration defaults to Earth" do
    oa = orbital_acceleration(100)
    assert oa == 9.52
  end

  test "Orbital acceleration for Jupiter at 100km" do
    oa = orbital_acceleration(PlanetList.select[:jupiter], 100)
    assert oa == 24.66
  end

  # Orbital Term

  test "orbital term for an object at 100km" do
    ot = orbital_term(PlanetList.select[:earth], 100)
    assert_in_delta ot, 1.5, 0.1
  end

  test "orbital term defaults to Earth" do
    ot = orbital_term(100)
    assert_in_delta ot, 1.5, 0.1
  end

  test "Orbital term for Saturn at 6000km" do
    ot = orbital_term(PlanetList.select[:saturn], 6000)
    assert Calcs.to_nearest_tenth(ot) == 4.9
  end

  # Height for a given orbital term

  test "height_for_orbital_term for a known orbital term" do
    height = height_for_orbital_term(1.439166)
    assert_in_delta height, 100, 0.5
  end

  test "height_for_orbital_term for 4 hours" do
    height = (height_for_orbital_term(4) |> Calcs.to_nearest_tenth)
    assert height == 6420
  end
end
