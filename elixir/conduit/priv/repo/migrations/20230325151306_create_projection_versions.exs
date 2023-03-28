defmodule Conduit.Repo.Migrations.CreateProjectionVersions do
  @moduledoc """
  This table is used to track which events each projector has seen, to
  ignore events already seen, resending events, as the event store guarantees
  that at-least-once delivery of events.
  """
  use Ecto.Migration

  def change do
    create table(:projection_versions, primary_key: false) do
      add :projection_name, :string, primary_key: true
      add :last_seen_event_number, :bigint

      timestamps()
    end
  end
end
