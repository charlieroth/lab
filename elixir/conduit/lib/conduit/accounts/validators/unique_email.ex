defmodule Conduit.Accounts.Validators.UniqueEmail do
  use Vex.Validator

  def validate(value, _opts) do
    Vex.Validators.By.validate(value,
      function: fn value -> !email_registered?(value) end,
      message: "has already been taken"
    )
  end

  defp email_registered?(email) do
    case Conduit.Accounts.user_by_email(email) do
      nil -> false
      _ -> true
    end
  end
end
