defmodule Conduit.AccountsTest do
  use Conduit.DataCase

  alias Conduit.Accounts
  alias Conduit.Accounts.Projections.User

  describe "register user" do
    @tag :integration
    test "should succeed with valid data" do
      assert {:ok, %User{} = user} = Accounts.register_user(build(:user))

      assert user.username == "test"
      assert user.email == "test@email.com"
      assert user.bio == "testing"
      assert user.image == "https://i.stack.imgur.com/xHWG8.jpg"
      assert user.hashed_password == "pass123"
    end
  end
end
