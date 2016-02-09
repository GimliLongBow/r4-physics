defmodule RocketryTest do
  use ExUnit.Case
  doctest Physics

  # Escape Velocity!

  test "escape_velocity for a given planet" do
    ev = Physics.Rocketry.escape_velocity(Planets.earth)
    assert ev == 11.2
  end

  test "escape velocity for Earth" do
    ev = Physics.Rocketry.escape_velocity(:earth)
    assert ev == 11.2
  end

  test "escape velocity for Moon" do
    ev = Physics.Rocketry.escape_velocity(:moon)
    assert ev == 2.4
  end

  test "escape velocity for Mars" do
    ev = Physics.Rocketry.escape_velocity(:mars)
    assert ev == 5.1
  end

  test "escape velocity for a random planet" do
    ev = %{mass: 2.0e24, radius: 5.5e6}
      |> Physics.Rocketry.escape_velocity
    assert ev == 7.0
  end

  # Orbital Speed

  test "orbital_speed for a given planet and height in kilometers" do
    os = Physics.Rocketry.orbital_speed(Planets.earth, 100)
    assert os == 7846.404191259335
  end

  test "orbital_speed defaults to Earth" do
    os = Physics.Rocketry.orbital_speed(100)
    assert os == 7846.404191259335
  end

  # Orbital Acceleration

  test "orbital acceleration for Earth at 100km" do
    oa = Physics.Rocketry.orbital_acceleration(Planets.earth, 100)
    assert oa == 9.52
  end

  test "orbital acceleration defaults to Earth" do
    oa = Physics.Rocketry.orbital_acceleration(100)
    assert oa == 9.52
  end

  test "orbital acceleration accepts an atom for Earth" do
    oa = Physics.Rocketry.orbital_acceleration(:earth, 100)
    assert oa == 9.52
  end

  test "orbital acceleration accepts an atom for Mars" do
    oa = Physics.Rocketry.orbital_acceleration(:mars, 100)
    assert oa == 3.48
  end

  test "orbital acceleration accepts an atom for the Moon" do
    oa = Physics.Rocketry.orbital_acceleration(:moon, 100)
    assert oa == 1.46
  end

  # Orbital Term

  test "orbital term for an object at 100km" do
    ot = Physics.Rocketry.orbital_term(Planets.earth, 100)
    assert_in_delta ot, 2, 1
  end

  test "orbital term defaults to Earth" do
    ot = Physics.Rocketry.orbital_term(100)
    assert_in_delta ot, 2, 1
  end

  test "orbital term accepts an atom for Earth" do
    ot = Physics.Rocketry.orbital_term(:earth, 100)
    assert_in_delta ot, 2, 1
  end

  test "orbital term accepts an atom for Mars" do
    ot = Physics.Rocketry.orbital_term(:mars, 100)
    assert_in_delta ot, 2, 1
  end

  test "orbital term accepts an atom for the Moon" do
    ot = Physics.Rocketry.orbital_term(:moon, 100)
    assert_in_delta ot, 2, 1
  end

  # Height for a given orbital term

  test "height_for_orbital_term for a known orbital term" do
    height = Physics.Rocketry.height_for_orbital_term(1.439166)
    assert_in_delta height, 100, 2
  end

  test "height_for_orbital_term for 4 hours" do
    height = (Physics.Rocketry.height_for_orbital_term(4) |> Calcs.to_nearest_tenth)
    assert height == 6420
  end
end
