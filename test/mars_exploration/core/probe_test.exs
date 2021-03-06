defmodule MarsExploration.Core.ProbeTest do
  use ExUnit.Case

  alias MarsExploration.Core.Probe

  describe "new/1" do
    @valid_params [
      %{actions: ["M", "L", "R"], direction: "N", column: 0, line: 0},
      %{actions: ["L"], direction: "S", column: :rand.uniform(100), line: :rand.uniform(100)},
      %{actions: ["R"], direction: "E", column: :rand.uniform(100), line: :rand.uniform(100)},
      %{actions: ["M"], direction: "W", column: :rand.uniform(100), line: :rand.uniform(100)}
    ]

    @invalid_params [
      Map.new(),
      %{actions: nil, direction: nil, column: nil, line: nil},
      %{actions: [], direction: nil, column: nil},
      %{actions: [], direction: nil},
      %{actions: nil},
      %{actions: ["Z"], direction: "N", column: [], line: -1},
      %{actions: ["12"], direction: "S", column: -12, line: :rand.uniform(100)}
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

  describe "get_next_action/1" do
    @probe_params %{actions: ["M", "L", "R"], direction: "N", column: 0, line: 0}

    test "must return next action in probe" do
      probe = Probe.new(@probe_params)

      Enum.each(probe.actions, fn _action ->
        assert {:ok, action, probe} = Probe.get_next_action(probe)
        assert action not in probe.actions == true
      end)
    end

    test "must return a error when probe actions is empty" do
      probe = Probe.new(%{actions: [], direction: "N", column: 0, line: 0})

      assert {:error, :not_found, probe} = Probe.get_next_action(probe)
    end
  end

  describe "perform_action/2" do
    test "must turn direction to W(est) when receive L(eft) action and current direction is N(orth)" do
      params = %{actions: ["M"], direction: "N", column: 0, line: 0}
      probe = Probe.new(params)

      assert {:ok, probe, updated_probe} = Probe.perform_action(probe, "L")
      assert updated_probe.direction == "W"
      assert updated_probe.column == 0
      assert updated_probe.line == 0
    end

    test "must turn direction to E(ast) when receive R(ight) action and current direction is N(orth)" do
      params = %{actions: ["M"], direction: "N", column: 0, line: 0}
      probe = Probe.new(params)

      assert {:ok, probe, updated_probe} = Probe.perform_action(probe, "R")
      assert updated_probe.direction == "E"
      assert updated_probe.column == 0
      assert updated_probe.line == 0
    end

    test "must increment column value when receive M(ove) action and current direction is N(orth)" do
      params = %{actions: ["M"], direction: "N", column: 0, line: 0}
      probe = Probe.new(params)

      assert {:ok, probe, updated_probe} = Probe.perform_action(probe, "M")
      assert updated_probe.direction == "N"
      assert updated_probe.column == 1
      assert updated_probe.line == 0
    end

    test "must turn direction to S(outh) when receive L(eft) action and current direction is W(est)" do
      params = %{actions: ["M"], direction: "W", column: 0, line: 0}
      probe = Probe.new(params)

      assert {:ok, probe, updated_probe} = Probe.perform_action(probe, "L")
      assert updated_probe.direction == "S"
      assert updated_probe.column == 0
      assert updated_probe.line == 0
    end

    test "must turn direction to N(orth) when receive R(ight) action and current direction is W(est)" do
      params = %{actions: ["M"], direction: "W", column: 0, line: 0}
      probe = Probe.new(params)

      assert {:ok, probe, updated_probe} = Probe.perform_action(probe, "R")
      assert updated_probe.direction == "N"
      assert updated_probe.column == 0
      assert updated_probe.line == 0
    end

    test "must decrement line value when receive M(ove) action and current direction is W(est)" do
      params = %{actions: ["M"], direction: "W", column: 0, line: 1}
      probe = Probe.new(params)

      assert {:ok, probe, updated_probe} = Probe.perform_action(probe, "M")
      assert updated_probe.direction == "W"
      assert updated_probe.column == 0
      assert updated_probe.line == 0
    end

    test "must not decrement line value when receive M(ove) action and current direction is W(est)" do
      params = %{actions: ["M"], direction: "W", column: 0, line: 0}
      probe = Probe.new(params)

      assert {:error, :invalid_action, probe} = Probe.perform_action(probe, "M")
      assert probe.direction == "W"
      assert probe.column == 0
      assert probe.line == 0
    end

    test "must turn direction to E(ast) when receive L(eft) action and current direction is S(outh)" do
      params = %{actions: ["M"], direction: "S", column: 0, line: 0}
      probe = Probe.new(params)

      assert {:ok, probe, updated_probe} = Probe.perform_action(probe, "L")
      assert updated_probe.direction == "E"
      assert updated_probe.column == 0
      assert updated_probe.line == 0
    end

    test "must turn direction to W(est) when receive R(ight) action and current direction is S(outh)" do
      params = %{actions: ["M"], direction: "S", column: 0, line: 0}
      probe = Probe.new(params)

      assert {:ok, probe, updated_probe} = Probe.perform_action(probe, "R")
      assert updated_probe.direction == "W"
      assert updated_probe.column == 0
      assert updated_probe.line == 0
    end

    test "must decrement column value when receive M(ove) action and current direction is S(outh)" do
      params = %{actions: ["M"], direction: "S", column: 1, line: 0}
      probe = Probe.new(params)

      assert {:ok, probe, updated_probe} = Probe.perform_action(probe, "M")
      assert updated_probe.direction == "S"
      assert updated_probe.column == 0
      assert updated_probe.line == 0
    end

    test "must not decrement column value when receive M(ove) action and current direction is S(outh)" do
      params = %{actions: ["M"], direction: "S", column: 0, line: 0}
      probe = Probe.new(params)

      assert {:error, :invalid_action, probe} = Probe.perform_action(probe, "M")
      assert probe.direction == "S"
      assert probe.column == 0
      assert probe.line == 0
    end

    test "must turn direction to N(orth) when receive L(eft) action and current direction is E(ast)" do
      params = %{actions: ["M"], direction: "E", column: 0, line: 0}
      probe = Probe.new(params)

      assert {:ok, probe, updated_probe} = Probe.perform_action(probe, "L")
      assert updated_probe.direction == "N"
      assert updated_probe.column == 0
      assert updated_probe.line == 0
    end

    test "must turn direction to N(orth) when receive R(ight) action and current direction is E(ast)" do
      params = %{actions: ["M"], direction: "E", column: 0, line: 0}
      probe = Probe.new(params)

      assert {:ok, probe, updated_probe} = Probe.perform_action(probe, "R")
      assert updated_probe.direction == "S"
      assert updated_probe.column == 0
      assert updated_probe.line == 0
    end

    test "must increment line value when receive M(ove) action and current direction is E(ast)" do
      params = %{actions: ["M"], direction: "E", column: 0, line: 0}
      probe = Probe.new(params)

      assert {:ok, probe, updated_probe} = Probe.perform_action(probe, "M")
      assert updated_probe.direction == "E"
      assert updated_probe.column == 0
      assert updated_probe.line == 1
    end
  end
end
