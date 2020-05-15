defmodule MarsExploration.Probe do
  @enforce_keys [:direction, :column, :line]
  @valid_directions ["N", "S", "E", "W"]
  @valid_actions ["L", "R", "M"]

  defstruct @enforce_keys

  def new(params) do
    if params_are_valid?(params) do
      struct!(__MODULE__, params)
    else
      raise ArgumentError, "Invalid params"
    end
  end

  def perform_action(%__MODULE__{} = probe, "L"), do: {:ok, probe, turn_left(probe)}
  def perform_action(%__MODULE__{} = probe, "R"), do: {:ok, probe, turn_right(probe)}

  def perform_action(%__MODULE__{} = probe, action) do
    with true <- action_is_valid?(action),
         %__MODULE__{} = updated_probe <- move(probe),
         true <- Map.get(updated_probe, :column) |> position_is_valid?(),
         true <- Map.get(updated_probe, :line) |> position_is_valid?() do
      {:ok, probe, updated_probe}
    else
      _ -> {:error, :invalid_action, probe}
    end
  end

  defp turn_left(%{direction: "N"} = probe), do: Map.put(probe, :direction, "W")
  defp turn_left(%{direction: "S"} = probe), do: Map.put(probe, :direction, "E")
  defp turn_left(%{direction: "E"} = probe), do: Map.put(probe, :direction, "N")
  defp turn_left(%{direction: "W"} = probe), do: Map.put(probe, :direction, "S")

  defp turn_right(%{direction: "N"} = probe), do: Map.put(probe, :direction, "E")
  defp turn_right(%{direction: "S"} = probe), do: Map.put(probe, :direction, "W")
  defp turn_right(%{direction: "E"} = probe), do: Map.put(probe, :direction, "S")
  defp turn_right(%{direction: "W"} = probe), do: Map.put(probe, :direction, "N")

  defp move(%{direction: "N", column: column} = probe), do: Map.put(probe, :column, column + 1)
  defp move(%{direction: "S", column: column} = probe), do: Map.put(probe, :column, column - 1)
  defp move(%{direction: "E", line: line} = probe), do: Map.put(probe, :line, line + 1)
  defp move(%{direction: "W", line: line} = probe), do: Map.put(probe, :line, line - 1)

  defp params_are_valid?(params) when is_map(params) do
    direction_is_valid?(params) and position_is_valid?(params)
  end

  defp direction_is_valid?(params) when is_map(params) do
    Map.get(params, :direction) in @valid_directions
  end

  defp position_is_valid?(params) when is_map(params) do
    Map.has_key?(params, :column) and
    Map.has_key?(params, :line) and
    params |> Map.get(:column) |> position_is_valid?() and
    params |> Map.get(:line) |> position_is_valid?()
  end

  defp position_is_valid?(value) when is_integer(value), do: value >= 0

  defp position_is_valid?(_position), do: false

  defp action_is_valid?(action) when is_binary(action) and action in @valid_actions, do: true

  defp action_is_valid?(_action), do: false
end
