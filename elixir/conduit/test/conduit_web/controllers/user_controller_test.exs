defmodule ConduitWeb.UserControllerTest do
  use ConduitWeb.ConnCase

  import Conduit.Factory

  alias Conduit.Accounts

  def fixture(:user, attrs \\ []) do
    build(:user, attrs) |> Accounts.create_user()
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "register user" do
    @tag :web
    test "should create and return user when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/users", user: build(:user))
      json = json_response(conn, 201)["user"]
      assert json == build(:user, bio: nil, image: nil)
    end

    @tag :web
    test "should not create user and render errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/users", user: build(:user, username: nil))

      assert json_response(conn, 422)["errors"] == [
               username: ["can't be blank"]
             ]
    end

    @tag :web
    test "should not create user and render errors when username has been taken", %{conn: conn} do
      # register a user
      {:ok, _user} = fixture(:user)

      # attempt to register the same user
      conn = post(conn, ~p"/api/users", user: build(:user, email: "test2@email.com"))

      assert json_response(conn, 422)["errors"] == [
               username: ["has already been taken"]
             ]
    end
  end
end
