defmodule Conduit.Accounts.Aggregates.UserTest do
  use Conduit.AggregateCase, aggregate: Conduit.Accounts.Aggregates.User

  alias Conduit.Accounts.Events.UserRegistered

  describe "register user" do
    @tag :unit
    test "should succeed when valid" do
      uuid = UUID.uuid4()

      assert_events(
        build(:register_user, uuid: uuid),
        [
          %UserRegistered{
            uuid: uuid,
            username: "test",
            email: "test@email.com",
            hashed_password: "pass123"
          }
        ]
      )
    end
  end
end
