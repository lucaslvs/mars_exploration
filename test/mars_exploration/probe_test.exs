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

  describe "perform_action/2" do
    test "must turn direction to W(est) when receive L(eft) action and current direction is N(orth)" do
      params = %{direction: "N", column: 0, line: 0}
      probe = Probe.new(params)
      assert {:ok, probe, updated_probe} = Probe.perform_action(probe, "L")
      assert updated_probe.direction == "W"
    end

    test "must turn direction to E(ast) when receive R(ight) action and current direction is N(orth)" do
      params = %{direction: "N", column: 0, line: 0}
      probe = Probe.new(params)
      assert {:ok, probe, updated_probe} = Probe.perform_action(probe, "R")
      assert updated_probe.direction == "E"
    end

    test "must turn direction to S(outh) when receive L(eft) action and current direction is W(est)" do
      params = %{direction: "W", column: 0, line: 0}
      probe = Probe.new(params)
      assert {:ok, probe, updated_probe} = Probe.perform_action(probe, "L")
      assert updated_probe.direction == "S"
    end

    test "must turn direction to N(orth) when receive R(ight) action and current direction is W(est)" do
      params = %{direction: "W", column: 0, line: 0}
      probe = Probe.new(params)
      assert {:ok, probe, updated_probe} = Probe.perform_action(probe, "R")
      assert updated_probe.direction == "N"
    end

    test "must turn direction to E(ast) when receive L(eft) action and current direction is S(outh)" do
      params = %{direction: "S", column: 0, line: 0}
      probe = Probe.new(params)
      assert {:ok, probe, updated_probe} = Probe.perform_action(probe, "L")
      assert updated_probe.direction == "E"
    end

    test "must turn direction to W(est) when receive R(ight) action and current direction is S(outh)" do
      params = %{direction: "S", column: 0, line: 0}
      probe = Probe.new(params)
      assert {:ok, probe, updated_probe} = Probe.perform_action(probe, "R")
      assert updated_probe.direction == "W"
    end

    test "must turn direction to N(orth) when receive L(eft) action and current direction is E(ast)" do
      params = %{direction: "E", column: 0, line: 0}
      probe = Probe.new(params)
      assert {:ok, probe, updated_probe} = Probe.perform_action(probe, "L")
      assert updated_probe.direction == "N"
    end

    test "must turn direction to N(orth) when receive R(ight) action and current direction is E(ast)" do
      params = %{direction: "E", column: 0, line: 0}
      probe = Probe.new(params)
      assert {:ok, probe, updated_probe} = Probe.perform_action(probe, "R")
      assert updated_probe.direction == "S"
    end
  end
end
