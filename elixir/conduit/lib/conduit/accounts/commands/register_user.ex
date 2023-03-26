defmodule Conduit.Accounts.Commands.RegisterUser do
  defstruct [:uuid, :username, :email, :password, :hashed_password]

  use ExConstructor
  use Vex.Struct

  validates(:uuid, uuid: true)
  validates(:username, presence: [message: "can't be empty"], string: true, unique_username: true)
  validates(:email, presence: [message: "can't be empty"], string: true)
  validates(:hashed_password, presence: [message: "can't be empty"], string: true)
end
