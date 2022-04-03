defmodule SimpleQueue do
  use GenServer

  def start_link(state \\ []) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def init(state) do
    {:ok, state}
  end

  def handle_call(:queue, _from, state) do
    {:reply, state, state}
  end

  def handle_call(:dequeue, _from, [value | state]) do
    {:reply, value, state}
  end

  def handle_call(:dequeue, _from, []) do
    {:reply, nil, []}
  end

  def handle_cast({:enqueue, value}, state) do
    {:noreply, state ++ [value]}
  end

  def queue(), do: GenServer.call(__MODULE__, :queue)
  def dequeue(), do: GenServer.call(__MODULE__, :dequeue)
  def enqueue(value), do: GenServer.cast(__MODULE__, {:enqueue, value})
end
