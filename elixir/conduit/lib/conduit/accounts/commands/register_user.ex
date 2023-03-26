defmodule Conduit.Accounts.Commands.RegisterUser do
  defstruct [:uuid, :username, :email, :password, :hashed_password]

  use ExConstructor
  use Vex.Struct

  alias Conduit.Accounts.Commands.RegisterUser

  validates(:uuid, uuid: true)

  validates(:username,
    presence: [message: "can't be empty"],
    format: [with: ~r/^[a-z0-9]+$/, allow_nil: true, allow_blank: true, message: "is invalid"],
    string: true,
    unique_username: true
  )

  validates(
    :email,
    presence: [message: "can't be empty"],
    format: [with: ~r/\S+@\S+\.\S+/, allow_nil: true, allow_blank: true, message: "is invalid"],
    string: true,
    unique_email: true
  )

  validates(:hashed_password, presence: [message: "can't be empty"], string: true)

  def assign_uuid(%RegisterUser{} = command, uuid) do
    %RegisterUser{command | uuid: uuid}
  end

  def downcase_username(%RegisterUser{username: username} = command) do
    %RegisterUser{command | username: String.downcase(username)}
  end

  def downcase_email(%RegisterUser{email: email} = command) do
    %RegisterUser{command | email: String.downcase(email)}
  end
end

defimpl Conduit.Support.Middleware.Uniqueness.UniqueFields,
  for: Conduit.Accounts.Commands.RegisterUser do
  def unique(_command) do
    [
      {:username, "has already been taken"},
      {:email, "has already been taken"}
    ]
  end
end
