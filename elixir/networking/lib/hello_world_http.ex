defmodule HelloWorldHTTP do
  @moduledoc """
  A very simple HTTP server

  This can be tested by, in an iex shell, running:

  ```
    iex(6)> {:ok, pid} = ThousandIsland.start_link(handler_module: HelloWorldHTTP)
  ```

  and then opening http://localhost:4000 in a browser
  """
  use ThousandIsland.Handler

  @impl ThousandIsland.Handler
  def handle_data(_data, socket, state) do
    ThousandIsland.Socket.send(socket, "HTTP/1.1 200 OK\r\n\r\nHello, World")
    {:close, state}
  end
end
