defmodule MarsExploration.Core do
  alias MarsExploration.Core.{Highland, Probe}

  def create_highland(line, column) do
    highland =
      Map.new()
      |> Map.put(:line, line)
      |> Map.put(:column, column)
      |> Highland.new()

    {:ok, highland}
  rescue
    _ ->
      :error
  end

  def create_probe(line, column, direction, actions) do
    probe =
      Map.new()
      |> Map.put(:line, line)
      |> Map.put(:column, column)
      |> Map.put(:direction, direction)
      |> Map.put(:actions, actions)
      |> Probe.new()

    {:ok, probe}
  rescue
    _ ->
      :error
  end

  def set_probe_in_highland(%Highland{} = highland, %Probe{} = probe) do
    Highland.push_probe(highland, probe)
  end

  def perform_action(%Highland{probes: probes} = highland, %Probe{} = probe, action) do
    with {:ok, probe, %{column: column, line: line} = new_probe} <-
           Probe.perform_action(probe, action),
         true <- Highland.has_position?(highland, column, line) do
      updated_probes = update_probe(probes, probe, new_probe)
      {:ok, Map.put(highland, :probes, updated_probes)}
    else
      _ ->
        {:error, highland}
    end
  end

  defp update_probe(probes, %{column: column, line: line, direction: direction}, new_probe) do
    for probe <- probes do
      if probe.column == column and probe.line == line and probe.direction == direction do
        new_probe
      else
        probe
      end
    end
  end
end
