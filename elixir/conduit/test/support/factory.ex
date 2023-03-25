defmodule Conduit.Factory do
  use ExMachina

  def user_factory do
    %{
      email: "test@email.com",
      username: "test",
      hashed_password: "testtest",
      bio: "I like to test things",
      image: "https://i.stack.imgur.com/xHWG8.jpg"
    }
  end
end
