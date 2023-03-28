defmodule Conduit.AggregateCase do
  @moduledoc """
  Defines the test case to be used by aggregate tests
  """

  use ExUnit.CaseTemplate

  using aggregate: aggregate do
    quote bind_quoted: [aggregate: aggregate] do
      @aggregate_module aggregate

      import Conduit.Factory

      # Assert that the expected events are returned when the given commands
      # have been executed
      defp assert_events(commands, expected_events) do
        assert execute(List.wrap(commands)) == expected_events
      end

      # Execute one or more commands against the aggregate
      defp execute(commands) do
        {_, events} =
          Enum.reduce(commands, {%@aggregate_module{}, []}, fn command, {aggregate, _} ->
            events = @aggregate_module.execute(aggregate, command)
            {evolve(aggregate, events), events}
          end)

        List.wrap(events)
      end

      # Evolve the aggregate state with the given events
      defp evolve(aggregate, events) do
        events
        |> List.wrap()
        |> Enum.reduce(aggregate, fn event, aggregate ->
          @aggregate_module.apply(aggregate, event)
        end)
      end
    end
  end
end
