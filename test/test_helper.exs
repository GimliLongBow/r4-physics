ExUnit.start()

defmodule Helpers do
  def check_flare_count do
    {:ok, pid} =   Postgrex.Connection.start_link(hostname: "localhost", database: "redfour_test")
    res = Postgrex.Connection.query!(pid, "select count(1) from solar_flares;", [])
    Postgrex.Connection.stop(pid)
    [[count] | rest] = res.rows
    count
  end
end
