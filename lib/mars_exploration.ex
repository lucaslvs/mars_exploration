defmodule MarsExploration do
  alias MarsExploration.Core

  def main([file]) do
    try do
      file
      |> parse_parameters()
      |> create_highland()
      |> create_probes()
      |> set_probes()
      |> launch_probes()
      |> print_result()
    rescue
      _ -> System.halt(1)
    end
  end

  def main(_arguments), do: IO.puts("Invalid arguments")

  defp parse_parameters(file) do
    read_file =
      file
      |> Path.expand()
      |> File.read()

    case read_file do
      {:ok, content} ->
        String.split(content, "\n")

      {:error, :enoent} ->
        IO.puts("The file #{file} does not exist")

      {:error, :eisdir} ->
        IO.puts("The named file #{file} is a directory")

      _ ->
        IO.puts("Invalid file")
    end
  end

  defp create_highland([highland_params | params]) do
    [line, column] =
      highland_params
      |> String.split(" ", trim: true)
      |> Enum.map(&String.to_integer/1)

    {:ok, highland} = Core.create_highland(line, column)
    {:ok, params, highland: highland}
  rescue
    _ ->
      :error
  end

  defp create_probes({:ok, probe_params, highland: highland}) do
    [probe_1_direction | probe_params] = probe_params
    [probe_1_actions | probe_params] = probe_params
    [probe_2_direction | probe_params] = probe_params
    [probe_2_actions] = probe_params

    [probe_1_line, probe_1_column, probe_1_direction] =
      String.split(probe_1_direction, " ", trim: true)

    probe_1_actions = String.split(probe_1_actions, "", trim: true)

    [probe_2_line, probe_2_column, probe_2_direction] =
      String.split(probe_2_direction, " ", trim: true)

    probe_2_actions = String.split(probe_2_actions, "", trim: true)

    {:ok, probe_1} =
      Core.create_probe(
        String.to_integer(probe_1_line),
        String.to_integer(probe_1_column),
        probe_1_direction,
        probe_1_actions
      )

    {:ok, probe_2} =
      Core.create_probe(
        String.to_integer(probe_2_line),
        String.to_integer(probe_2_column),
        probe_2_direction,
        probe_2_actions
      )

    {:ok, highland: highland, probes: [probe_1, probe_2]}
  rescue
    _ ->
      :error
  end

  defp create_probes(error), do: error

  defp set_probes({:ok, highland: highland, probes: probes}) do
    highland = Enum.reduce(probes, highland, fn probe, updated_highland ->
      {:ok, highland} = Core.set_probe_in_highland(updated_highland, probe)

      highland
    end)

    {:ok, highland}
  rescue
    _ ->
      :error
  end

  defp set_probes(error), do: error

  defp launch_probes({:ok, %{probes: probes} = highland}) do
    highland = Enum.reduce_while(probes, highland, fn probe, updated_highland ->
      if Core.all_probe_actions_have_been_completed?(updated_highland) do
        {:halt, updated_highland}
      else
        {_, updated_highland} = Core.perform_next_action(updated_highland, probe)
        {:cont, updated_highland}
      end
    end)

    if Core.all_probe_actions_have_been_completed?(highland) do
      highland
    else
      launch_probes({:ok, highland})
    end
  rescue
    _ ->
      :error
  end

  defp launch_probes(error), do: error

  defp print_result(%{probes: probes}) do
    Enum.each(probes, fn probe ->
      IO.puts("#{probe.line} #{probe.column} #{probe.direction}")
    end)
  end
end
