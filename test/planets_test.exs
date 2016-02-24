defmodule PlanetsTest do
  use ExUnit.Case
  import PlanetList

  test "load initializes the escape velocity of each planet" do
    Enum.each Planets.load, fn({_name, planet}) -> assert planet.ev > 0 end
  end

  test "select loads ev values" do
    assert select[:earth].ev == 11.2
  end

  test "select returns the correct name" do
    assert select[:earth].name == "Earth"
  end
end
