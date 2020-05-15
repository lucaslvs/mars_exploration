defmodule MarsExploration.Highland do
  alias MarsExploration.Probe

  @enforce_keys [:column, :line, :probes]

  defstruct @enforce_keys

  def new(params) do
    if params_are_valid?(params) do
      params = Map.put(params, :probes, [])
      struct!(__MODULE__, params)
    else
      raise ArgumentError, "Invalid params"
    end
  end

  def push_probe(%__MODULE__{probes: probes} = highland, %Probe{} = probe) do
    cond do
      Enum.empty?(highland.probes) and has_position?(highland, probe.column, probe.line) ->
        probes = List.insert_at(probes, -1, probe)
        {:ok, Map.put(highland, :probes, probes)}

      not has_probe_in_position?(highland, probe.column, probe.line) ->
        probes = List.insert_at(probes, -1, probe)
        {:ok, Map.put(highland, :probes, probes)}

      true ->
        {:error, highland}
    end
  end

  def has_probe_in_position?(%__MODULE__{} = highland, column, line) do
    with true <- has_position?(highland, column, line),
         {:ok, _probe, _highland} <- get_probe_by_position(highland, column, line) do
      true
    else
      _ ->
        false
    end
  end

  def has_position?(%__MODULE__{} = highland, column, line) do
    highland.column <= column and highland.line <= line
  end

  defp params_are_valid?(params) when is_map(params) do
    position_is_valid?(params)
  end

  defp position_is_valid?(params) when is_map(params) do
    Map.has_key?(params, :column) and
    Map.has_key?(params, :line) and
    params |> Map.get(:column) |> position_is_valid?() and
    params |> Map.get(:line) |> position_is_valid?()
  end

  defp position_is_valid?(value) when is_integer(value), do: value >= 0

  defp position_is_valid?(_position), do: false

  defp get_probe_by_position(%{probes: probes} = highland, column, line) do
    probe = Enum.find(probes, fn probe ->
      column == probe.column and line == probe.line
    end)

    if is_nil(probe) do
      {:error, :not_found, highland}
    else
      {:ok, probe, highland}
    end
  end
end
