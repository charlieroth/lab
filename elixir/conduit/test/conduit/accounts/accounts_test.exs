defmodule Conduit.AccountsTest do
  use Conduit.DataCase

  alias Conduit.Auth
  alias Conduit.Accounts
  alias Conduit.Accounts.Projections.User

  describe "register user" do
    @tag :integration
    test "should succeed with valid data" do
      assert {:ok, %User{} = user} = Accounts.register_user(build(:user))

      assert user.username == "test"
      assert user.email == "test@email.com"
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

      assert {:error, :validation_failure, errors} =
               Accounts.register_user(build(:user, email: "test2@email.com"))

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

    @tag :integration
    test "should fail when email address already taken and return error" do
      assert {:ok, %User{} = user} = Accounts.register_user(build(:user))

      assert {:error, :validation_failure, errors} =
               Accounts.register_user(build(:user, username: "test2"))

      assert errors == %{email: ["has already been taken"]}
    end

    @tag :integration
    test "should fail when registering identical email addresses concurrently and return error" do
      1..2
      |> Enum.map(fn n ->
        Task.async(fn -> Accounts.register_user(build(:user, username: "test#{n}")) end)
      end)
      |> Enum.map(&Task.await/1)
    end

    @tag :integration
    test "should fail when when email address format is invalid and return error" do
      assert {:error, :validation_failure, errors} =
               Accounts.register_user(build(:user, email: "invalidemail"))

      assert errors == %{email: ["is invalid"]}
    end

    @tag :integration
    test "should convert email address to lowercase" do
      assert {:ok, %User{} = user} = Accounts.register_user(build(:user, email: "tEsT@eMaIl.cOm"))
      assert user.email == "test@email.com"
    end

    @tag :integration
    test "should hash password" do
      assert {:ok, %User{} = user} = Accounts.register_user(build(:user, email: "tEsT@eMaIl.cOm"))
      assert Auth.validate_password("pass123", user.hashed_password)
    end
  end
end
