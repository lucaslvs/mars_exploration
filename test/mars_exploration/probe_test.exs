defmodule MarsExploration.ProbeTest do
  use ExUnit.Case

  alias MarsExploration.Probe

  describe "new/1" do
    @valid_params [
      %{direction: "N", column: 0, line: 0},
      %{direction: "S", column: :rand.uniform(100), line: :rand.uniform(100)},
      %{direction: "E", column: :rand.uniform(100), line: :rand.uniform(100)},
      %{direction: "W", column: :rand.uniform(100), line: :rand.uniform(100)}
    ]

    @invalid_params [
      Map.new(),
      %{direction: nil, column: nil, line: nil},
      %{direction: nil, column: nil},
      %{direction: nil},
      %{direction: :rand.uniform(100), column: "nil", line: "2"},
      %{direction: "N", column: [], line: -1},
      %{direction: "S", column: -12, line: :rand.uniform(100)}
    ]

    test "must return a probe when receiving valid parameters" do
      Enum.each(@valid_params, fn params ->
        probe = Probe.new(params)

        assert %Probe{} = probe
        assert probe.direction == params.direction
        assert probe.column == params.column
        assert probe.line == params.line
      end)
    end

    test "must raise a ArgumentError when receiving invalid parameters" do
      Enum.each(@invalid_params, fn params ->
        assert_raise ArgumentError, "Invalid params", fn -> Probe.new(params) end
      end)
    end
  end
end
