defmodule Conduit.Factory do
  use ExMachina

  alias Conduit.Accounts.Commands.RegisterUser

  def user_factory do
    %{
      email: "test@email.com",
      username: "test",
      hashed_password: "pass123",
      bio: "testing",
      image: "https://i.stack.imgur.com/xHWG8.jpg"
    }
  end

  def register_user_factory do
    struct(RegisterUser, build(:user))
  end
end
