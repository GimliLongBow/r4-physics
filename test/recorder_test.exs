defmodule RecorderTest do
  use ExUnit.Case
  import Solar.FlareRecorder

  # Setup the test database and prepare for work!!!!
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
    Postgrex.Connection.stop(pid)
  end

  setup do
    # Truncate the solar flares table:
    {:ok, pid} = Postgrex.Connection.start_link(hostname: "localhost", database: "redfour_test")
    Postgrex.Connection.query!(pid, "TRUNCATE solar_flares;", [])
    Postgrex.Connection.stop(pid)
  end

  test "new recorder returns process ID" do
    {:ok, pid} = start_link()
    refute pid == nil
  end

  test "new recorder has no entries in the database" do
    {:ok, pid} = start_link()
    flares = current(pid)
    assert length(flares) == 0
  end

  test "record saves some flare data" do
    {:ok, pid} = start_link()
    record(pid, %{classification: :M, scale: 22})
    record(pid, %{classification: :X, scale: 33})
    res = current(pid)
    assert length(res) == 2
  end

end
