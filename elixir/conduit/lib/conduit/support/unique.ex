defmodule Conduit.Support.Unique do
  use GenServer

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  @spec claim(any, any) :: any
  def claim(key, value) do
    GenServer.call(__MODULE__, {:claim, key, value})
  end

  def init(state) do
    {:ok, state}
  end

  def handle_call({:claim, context, value}, _from, assignments) do
    {reply, state} =
      case Map.get(assignments, context) do
        nil ->
          {:ok, Map.put(assignments, context, MapSet.new([value]))}

        values ->
          case MapSet.member?(values, value) do
            true ->
              {{:error, :already_taken}, assignments}

            false ->
              {:ok, Map.put(assignments, context, MapSet.put(values, value))}
          end
      end

    {:reply, reply, state}
  end
end
