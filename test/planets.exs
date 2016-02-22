defmodule RocketryTest do
  use ExUnit.Case
  doctest Physics
  import Planets

  test "load returns a list of 9 planets" do
    assert count(load) == 9
  end
end
