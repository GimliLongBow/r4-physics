defmodule Solar do

  def power(%{classification: :X, scale: s}), do: s * 1000
  def power(%{classification: :M, scale: s}), do: s * 10
  def power(%{classification: :C, scale: s}), do: s * 1
end
