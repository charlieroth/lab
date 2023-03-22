defmodule Daytime do
  @moduledoc """
  RFC867 (Daytime) Protocol

  To test this, run the following in an iex session:

  ```
    iex(1)> {:ok, pid} = ThousandIsland.start_link(handler_module: Daytime)
    iex(2)> {:ok, conn} = Mint.HTTP.connect(:http, "localhost", 4000)
    iex(3)> flush()
    {:tcp, #Port<0.8>, "2023-03-22 16:48:34.631675Z"}
    :ok
  ```
  """
  use ThousandIsland.Handler

  @impl ThousandIsland.Handler
  def handle_connection(socket, state) do
    time = DateTime.utc_now() |> to_string()
    ThousandIsland.Socket.send(socket, time)
    {:close, state}
  end
end
