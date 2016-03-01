defmodule BombTest do
  use ExUnit.Case

  setup_all do
    {:ok, pid} = Postgrex.Connection.start_link(hostname: "localhost", database: "redfour_test")

    # Erase the flares, just in case:
    drop_sql = """
    DROP TABLE IF EXISTS solar_flares;
    """
    Postgrex.Connection.query!(pid, drop_sql, [])

    create_sql = """
    create table solar_flares(
      id serial primary key,
      classification char(1) not null,
      scale decimal(4,2) not null,
      date timestamptz not null
    );
    """
    Postgrex.Connection.query!(pid, create_sql, [])

    Postgrex.Connection.query!(pid, "alter table solar_flares add index int;", [])
    Postgrex.Connection.stop(pid)
  end

  setup do
    # Truncate the solar flares table:
    {:ok, pid} = Postgrex.Connection.start_link(hostname: "localhost", database: "redfour_test")
    Postgrex.Connection.query!(pid, "TRUNCATE solar_flares;", [])
    Postgrex.Connection.stop(pid)
  end

  # test "Waiting for recorder with 20 queries and 80 workers" do
  #   res = Enum.map 1..50, fn(n) ->
  #     spawn(Solar.FlareWorker, :run, [100])
  #   end
  #   :timer.sleep(1000)
  #   IO.inspect Helpers.check_flare_count
  # end
end
