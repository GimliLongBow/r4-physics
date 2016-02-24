defmodule Physics.Rocketry do
  import Calcs
  import Physics.Laws

  @earth PlanetList.select[:earth]

  def orbital_speed(height), do: orbital_speed(@earth, height)
  def orbital_speed(planet, height) do
    (newtons_gravitational_constant * planet.mass) / orbital_radius(planet.radius, height)
      |> square_root
  end

  def orbital_acceleration(height), do: orbital_acceleration(@earth, height)
  def orbital_acceleration(planet, height) do
    (orbital_speed(planet, height) |> squared) / orbital_radius(planet.radius, height)
      |> to_nearest_hundredth
  end

  def orbital_term(height), do: orbital_term(@earth, height)
  def orbital_term(planet, height) do
    (4 * (:math.pi |> squared) * (orbital_radius(planet.radius, height) |> cubed)) / (newtons_gravitational_constant * planet.mass)
      |> square_root
      |> seconds_to_hours
  end

  def height_for_orbital_term(hours), do: height_for_orbital_term(@earth, hours)
  def height_for_orbital_term(planet, hours) do
    radius_in_meters = (newtons_gravitational_constant * planet.mass * (hours |> hours_to_seconds |> squared)) / (4 * (:math.pi |> squared))
      |> cube_root

    subtract_planet(radius_in_meters, planet.radius) |> to_km
  end

  defp orbital_radius(radius_in_m, height_in_km) do
    radius_in_m + (height_in_km |> to_m)
  end

  defp subtract_planet(total_radius, planet_radius), do: total_radius - planet_radius
end
