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

  def perform_action(%__MODULE__{} = probe, action) do
    cond do
      not action_is_valid?(action) ->
        {:error, :invalid_move, probe}

      action == "L" ->
        {:ok, probe, turn_left(probe)}

      action == "R" ->
        {:ok, probe, turn_right(probe)}

      true ->
        {:ok, probe, move(probe)}
    end
  end

  defp params_are_valid?(params) when is_map(params) do
    direction_is_valid?(params) and position_is_valid?(params)
  end

  defp direction_is_valid?(params) when is_map(params) do
    Map.get(params, :direction) in @valid_directions
  end

  defp position_is_valid?(params) when is_map(params) do
    Map.has_key?(params, :column) and
      Map.has_key?(params, :line) and
      is_integer(Map.get(params, :column)) and
      is_integer(Map.get(params, :line)) and
      Map.get(params, :column) >= 0 and
      Map.get(params, :line) >= 0
  end

  defp action_is_valid?(action) when is_binary(action) and action in @valid_actions, do: true

  defp action_is_valid?(_action), do: false

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
end
