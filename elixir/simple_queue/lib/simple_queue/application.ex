defmodule SimpleQueue.Application do
  use Application

  @impl true
  def start(_type, _args) do
    # Strategies
    # :one_for_one = only restart the failed child process
    # :one_for_all = restart all child processes in the event of a failure
    # :rest_for_one = restart the failed processes and any processes started after

    children = [{SimpleQueue, [1, 2, 3]}]
    opts = [strategy: :one_for_one, name: SimpleQueue.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
