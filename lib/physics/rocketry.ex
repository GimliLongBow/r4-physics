defmodule Physics.Rocketry do
  import Calcs
  import Physics.Laws

  def escape_velocity(:earth) do
    Planets.earth
      |> escape_velocity
  end

  def escape_velocity(:moon) do
    Planets.moon
      |> escape_velocity
  end

  def escape_velocity(:mars) do
    Planets.mars
      |> escape_velocity
  end

  def escape_velocity(planet) when is_map(planet) do
    planet
      |> calculate_velocity
      |> to_km
      |> to_nearest_tenth
  end

  def orbital_speed(planet, height) do
    (newtons_gravitational_constant * planet.mass) / orbital_radius(planet.radius, height)
      |> square_root
  end

  def orbital_acceleration(planet, height) do
    (orbital_speed(planet, height) |> squared) / orbital_radius(planet.radius, height)
      |> to_nearest_hundredth
  end

  def orbital_term(planet, height) do
    (4 * (:math.pi |> squared) * (orbital_radius(planet.radius, height) |> cubed)) /
      (newtons_gravitational_constant * planet.mass)
      |> square_root
      |> seconds_to_hours
  end

  defp calculate_velocity(%{mass: mass, radius: radius}) do
    (2 * newtons_gravitational_constant * mass ) / radius
      |> square_root
  end

  defp orbital_radius(radius, height) do
    radius + (height |> to_m)
  end
end
