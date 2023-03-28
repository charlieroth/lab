defmodule Echo do
  @moduledoc """
  RFC862 (Echo) Protocol

  To test this, run the following in an iex session:

  ```
    iex(1)> {:ok, pid} = ThousandIsland.start_link(handler_module: Echo)
    iex(2)> {:ok, socket} = :gen_tcp.connect('localhost', 4000, active: false)
    iex(3)> :gen_tcp.send(socket, "message to echo")
    iex(4)> {:ok, data} = :gen_tcp.recv(socket, 0)
    {:ok, 'from echo: message to echo'}
  ```
  """
  use ThousandIsland.Handler

  @impl ThousandIsland.Handler
  def handle_data(data, socket, state) do
    ThousandIsland.Socket.send(socket, "from echo: #{data}")
    {:continue, state}
  end
end
