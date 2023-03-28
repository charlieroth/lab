defmodule ConduitWeb.ValidationJson do
  def error(%{errors: errors}) do
    %{errors: errors}
  end
end
