defmodule Conduit.Repo.Migrations.UpdateAccountsUsers do
  use Ecto.Migration

  def change do
    drop table(:accounts_users)

    create table(:accounts_users, primary_key: false) do
      add :uuid, :uuid, primary_key: true
      add :username, :string
      add :email, :string
      add :hashed_password, :string
      add :bio, :string
      add :image, :string

      timestamps()
    end

    create unique_index(:accounts_users, [:username])
    create unique_index(:accounts_users, [:email])
  end
end
