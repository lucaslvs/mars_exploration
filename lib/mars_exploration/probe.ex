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

  defp move(%__MODULE__{direction: direction, column: column, line: line} = probe) do
    case direction do
      "N" ->
        Map.put(probe, :column, column + 1)

      "S" ->
        Map.put(probe, :column, column - 1)

      "E" ->
        Map.put(probe, :line, line + 1)

      "W" ->
        Map.put(probe, :line, line - 1)
    end
  end

  defp turn_left(%__MODULE__{direction: direction} = probe) do
    case direction do
      "N" ->
        Map.put(probe, :direction, "W")

      "S" ->
        Map.put(probe, :direction, "E")

      "E" ->
        Map.put(probe, :direction, "N")

      "W" ->
        Map.put(probe, :direction, "S")
    end
  end

  defp turn_right(%__MODULE__{direction: direction} = probe) do
    case direction do
      "N" ->
        Map.put(probe, :direction, "E")

      "S" ->
        Map.put(probe, :direction, "W")

      "E" ->
        Map.put(probe, :direction, "S")

      "W" ->
        Map.put(probe, :direction, "N")
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
end
