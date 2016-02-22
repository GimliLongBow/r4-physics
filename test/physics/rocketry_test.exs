defmodule RocketryTest do
  use ExUnit.Case
  doctest Physics
  import Physics.Rocketry

  # Orbital Speed

  test "orbital_speed for a given planet and height in kilometers" do
    os = orbital_speed(Planets.select[:earth], 100)
    assert os == 7846.404191259335
  end

  test "orbital_speed defaults to Earth" do
    os = orbital_speed(100)
    assert os == 7846.404191259335
  end

  # Orbital Acceleration

  test "orbital acceleration for Earth at 100km" do
    oa = orbital_acceleration(Planets.select[:earth], 100)
    assert oa == 9.52
  end

  test "orbital acceleration defaults to Earth" do
    oa = orbital_acceleration(100)
    assert oa == 9.52
  end

  test "orbital acceleration accepts an atom for Earth" do
    oa = orbital_acceleration(:earth, 100)
    assert oa == 9.52
  end

  test "orbital acceleration accepts an atom for Mars" do
    oa = orbital_acceleration(:mars, 100)
    assert oa == 3.56
  end

  test "orbital acceleration accepts an atom for the Moon" do
    oa = orbital_acceleration(:moon, 100)
    assert oa == 1.46
  end

  # Orbital Term

  test "orbital term for an object at 100km" do
    ot = orbital_term(Planets.select[:earth], 100)
    assert_in_delta ot, 2, 1
  end

  test "orbital term defaults to Earth" do
    ot = orbital_term(100)
    assert_in_delta ot, 2, 1
  end

  test "orbital term accepts an atom for Earth" do
    ot = orbital_term(:earth, 100)
    assert_in_delta ot, 2, 1
  end

  test "orbital term accepts an atom for Mars" do
    ot = orbital_term(:mars, 100)
    assert_in_delta ot, 2, 1
  end

  test "orbital term accepts an atom for the Moon" do
    ot = orbital_term(:moon, 100)
    assert_in_delta ot, 2, 1
  end

  # Height for a given orbital term

  test "height_for_orbital_term for a known orbital term" do
    height = height_for_orbital_term(1.439166)
    assert_in_delta height, 100, 2
  end

  test "height_for_orbital_term for 4 hours" do
    height = (height_for_orbital_term(4) |> Calcs.to_nearest_tenth)
    assert height == 6420
  end
end
