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
      assert user.hashed_password == "pass123"
      assert user.bio == nil
      assert user.image == nil
    end

    @tag :integration
    test "should fail with invalid data and return errors" do
      assert {:error, :validation_failure, errors} =
               Accounts.register_user(build(:user, username: ""))

      assert errors == %{username: ["can't be empty"]}
    end

    @tag :integration
    test "should fail when username already taken and return error" do
      assert {:ok, %User{}} = Accounts.register_user(build(:user))
      assert {:error, :validation_failure, errors} = Accounts.register_user(build(:user))
      assert errors == %{username: ["has already been taken"]}
    end

    @tag :integration
    test "should fail when username format is invalid and return error" do
      assert {:error, :validation_failure, errors} =
               Accounts.register_user(build(:user, username: "te@st"))

      assert errors == %{username: ["is invalid"]}
    end

    @tag :integration
    test "should convert username to lowercase" do
      assert {:ok, %User{} = user} = Accounts.register_user(build(:user, username: "tEsT"))
      assert user.username == "test"
    end
  end
end
