defmodule PhysicsTest do
  use ExUnit.Case
  doctest Physics

  test "the truth" do
    assert 1 + 1 == 2
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

  test "orbital acceleration for Earth at 100km" do
    oa = Physics.Rocketry.orbital_acceleration(Planets.earth, 100)
    assert oa == 9.52
  end

  test "orbital term for an object at 100km" do
    ot = Physics.Rocketry.orbital_term(Planets.earth, 100)
    #assert_in_delta ot, 4, 1
  end
end
