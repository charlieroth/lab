defmodule Conduit.Accounts do
  @moduledoc """
  The Accounts context.
  """

  alias Conduit.Repo
  alias Conduit.Accounts.Commands.RegisterUser
  alias Conduit.Router

  @doc """
  Register a new user.
  """
  def register_user(attrs \\ %{}) do
    uuid = UUID.uuid4()

    command =
      attrs
      |> assign(:uuid, uuid)
      |> RegisterUser.new()

    with :ok <- Router.dispatch(command, consistency: :strong) do
      get(User, uuid)
    else
      reply ->
        reply
    end
  end

  defp get(schema, uuid) do
    case Repo.get(schema, uuid) do
      nil -> {:error, :not_found}
      projection -> {:ok, projection}
    end
  end

  defp assign(attrs, key, value), do: Map.put(attrs, key, value)
end
