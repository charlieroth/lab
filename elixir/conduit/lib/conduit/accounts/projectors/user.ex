defmodule Conduit.Accounts.Projectors.User do
  use Commanded.Projections.Ecto,
    application: Conduit.App,
    repo: Conduit.Repo,
    consistency: :strong,
    name: "Accounts.Projectors.User"

  alias Conduit.Accounts.Events.UserRegistered
  alias Conduit.Accounts.Projections.User

  project(%UserRegistered{} = event, _metadata, fn multi ->
    Ecto.Multi.insert(multi, :user, %User{
      uuid: event.uuid,
      username: event.username,
      email: event.email,
      hashed_password: event.hashed_password,
      bio: event.bio,
      image: event.image
    })
  end)
end
