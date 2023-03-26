defmodule Conduit.Accounts.Events.UserRegistered do
  @derive Jason.Encoder

  defstruct [
    :uuid,
    :username,
    :email,
    :hashed_password
  ]
end
