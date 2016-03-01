defmodule ProcessBench do
  use Benchfella

  bench "simple process spawn" do
    for n <- 1..5000, do: spawn(fn() -> 1+1 end)
    1
  end

end
