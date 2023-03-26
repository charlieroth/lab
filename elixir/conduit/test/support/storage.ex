defmodule Conduit.Storage do
  @doc """
  Clear the event store and read store databases
  """

  def reset!() do
    :ok = Application.stop(:conduit)
    :ok = Application.stop(:commanded)
    :ok = Application.stop(:eventstore)

    reset_eventstore()
    reset_readstore()

    {:ok, _} = Application.ensure_all_started(:conduit)
  end

  defp reset_eventstore() do
    config = Conduit.EventStore.config()
    {:ok, conn} = Postgrex.start_link(config)
    EventStore.Storage.Initializer.reset!(conn, config)
  end

  defp reset_readstore() do
    config = Application.get_env(:conduit, Conduit.Repo)
    {:ok, conn} = Postgrex.start_link(config)
    Postgrex.query!(conn, truncate_readstore_tables(), [])
  end

  defp truncate_readstore_tables() do
    """
    TRUNCATE TABLE
      accounts_users,
      projection_versions
    RESTART IDENTITY
    CASCADE;
    """
  end
end
