defmodule Conduit.Accounts.Supervisor do
  use Supervisor

  alias Conduit.Accounts

  def start_link(opts) do
    Supervisor.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def init(_opts) do
    children = [Accounts.Projectors.User]
    Supervisor.init(children, strategy: :one_for_one)
  end
end
