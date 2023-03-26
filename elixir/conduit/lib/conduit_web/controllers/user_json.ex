defmodule ConduitWeb.UserJSON do
  alias Conduit.Accounts.Projections.User

  @doc """
  Renders a list of users.
  """
  def index(%{users: users}) do
    %{users: for(user <- users, do: data(user))}
  end

  @doc """
  Renders a single user.
  """
  def show(%{user: user}) do
    %{user: data(user)}
  end

  defp data(%User{} = user) do
    %{
      username: user.username,
      email: user.email,
      bio: user.bio,
      image: user.image
    }
  end
end
