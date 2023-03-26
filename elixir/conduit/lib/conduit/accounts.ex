defmodule Conduit.Accounts do
  @moduledoc """
  The Accounts context.
  """

  alias Conduit.Repo
  alias Conduit.Accounts.Commands
  alias Conduit.Accounts.Projections
  alias Conduit.Accounts.Queries

  @doc """
  Register a new user.
  """
  def register_user(attrs \\ %{}) do
    uuid = UUID.uuid4()

    command =
      attrs
      |> assign(:uuid, uuid)
      |> Commands.RegisterUser.new()

    with :ok <- Conduit.App.dispatch(command, consistency: :strong) do
      case Repo.get(Projections.User, uuid) do
        nil -> {:error, :not_found}
        projection -> {:ok, projection}
      end
    else
      reply ->
        reply
    end
  end

  @doc """
  Get an existing user by their username, or return `nil` if not registered.
  """
  def user_by_username(username) do
    username
    |> String.downcase()
    |> Queries.UserByUsername.new()
    |> Repo.one()
  end

  defp assign(attrs, key, value), do: Map.put(attrs, key, value)
end
