defmodule Conduit.Router do
  use Commanded.Commands.Router

  alias Conduit.Accounts.Aggregates.User
  alias Conduit.Accounts.Commands.RegisterUser

  alias Conduit.Support.Middleware.{
    Validate,
    Uniqueness
  }

  middleware(Validate)
  middleware(Uniqueness)

  dispatch([RegisterUser], to: User, identity: :uuid)
end
