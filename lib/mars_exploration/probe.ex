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
end
