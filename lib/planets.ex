defmodule Planets do
  import Calcs
  import Physics.Laws

  defstruct [
    name: "",
    type: :empty,
    mass: 0,
    radius: 0,
    ev: 0
  ]

  def load do
    planets = %{
      mercury: %Planets{name: "Mercury", type: :rocky, mass: 3.3e23, radius: 2.439e6},
      venus: %Planets{name: "Venus", type: :rocky, mass: 4.86e24, radius: 6.05e6},
      earth: %Planets{name: "Earth", type: :rocky, mass: 5.972e24, radius: 6.37e6},
      mars: %Planets{name: "Mars", type: :rocky, mass: 6.41e23, radius: 3.37e6},
      jupiter: %Planets{name: "Jupiter", type: :gaseous, mass: 1.89e27, radius: 7.14e7},
      saturn: %Planets{name: "Saturn", type: :gaseous, mass: 5.68e26, radius: 6.02e7},
      uranus: %Planets{name: "Uranus", type: :gaseous, mass: 8.68e25, radius: 2.55e7},
      neptune: %Planets{name: "Neptune", type: :gaseous, mass: 1.02e26, radius: 2.47e7},
      moon: %Planets{name: "Moon", type: :rocky, mass: 7.35e22, radius: 1.738e6}
    }

    for {name, planet} <- planets, into: %{}, do: {name, %{planet | ev: escape_velocity(planet)}}
  end

  defp escape_velocity(planet) do
    (2 * newtons_gravitational_constant * planet.mass ) / planet.radius
      |> square_root
      |> to_km
      |> to_nearest_tenth
  end
end

defmodule PlanetList do
  @list Planets.load()

  def select, do: @list
end
