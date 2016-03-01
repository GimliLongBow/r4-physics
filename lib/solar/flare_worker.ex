defmodule Solar.FlareWorker do
  def run(spawns) when is_integer(spawns) do
    {:ok, pid} = Solar.FlareRecorder.start_link
    Enum.map 1..spawns, fn(n) ->
      Solar.FlareRecorder.record(pid, %{index: n, classification: :X, scale: 33})
    end
  end
end
