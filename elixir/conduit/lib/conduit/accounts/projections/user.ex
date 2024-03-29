defmodule Conduit.Accounts.Projections.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:uuid, :binary_id, autogenerate: false}
  @derive {Phoenix.Param, key: :uuid}

  schema "accounts_users" do
    field :username, :string
    field :email, :string
    field :hashed_password, :string
    field :bio, :string
    field :image, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :hashed_password])
    |> validate_required([:username, :email, :hashed_password])
  end
end
