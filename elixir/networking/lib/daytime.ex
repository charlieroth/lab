defmodule Daytime do
  @moduledoc """
  RFC867 (Daytime) Protocol
  """
  use ThousandIsland.Handler

  @impl ThousandIsland.Handler
  def handle_connection(socket, state) do
    time = DateTime.utc_now() |> to_string()
    ThousandIsland.Socket.send(socket, time)
    {:close, state}
  end
end
