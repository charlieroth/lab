defmodule Conduit.Accounts.Projectors.User do
  use Commanded.Projections.Ecto,
    application: Conduit.App,
    repo: Conduit.Repo,
    name: "Accounts.Projectors.User",
    consistency: :strong

  alias Conduit.Accounts.Events.UserRegistered
  alias Conduit.Accounts.Projections.User

  project(%UserRegistered{} = event, _metadata, fn multi ->
    Ecto.Multi.insert(multi, :user, %User{
      uuid: event.uuid,
      username: event.username,
      email: event.email,
      hashed_password: event.hashed_password,
      bio: nil,
      image: nil
    })
  end)
end
