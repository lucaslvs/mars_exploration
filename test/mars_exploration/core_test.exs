defmodule MarsExploration.CoreTest do
  use ExUnit.Case

  alias MarsExploration.Core
  alias MarsExploration.Core.{Highland, Probe}

  describe "create_highland/2" do
    test "should returns a highland when receive a valid position" do
      assert {:ok, %Highland{column: column, line: line}} = Core.create_highland(0, 0)
      assert column == 0
      assert line == 0
    end

    test "should return a error when receive a invalid position" do
      assert :error = Core.create_highland(nil, nil)
      assert :error = Core.create_highland("0", "0")
    end
  end

  describe "create_probe/4" do
    test "should return a probe when receive a valid parameters" do
      assert {:ok, %Probe{} = probe} = Core.create_probe(0, 0, "N", ["M"])
      assert probe.line == 0
      assert probe.column == 0
      assert probe.direction == "N"
      assert probe.actions == ["M"]
    end

    test "should return a error when receive a invalid parameters" do
      assert :error = Core.create_probe(-1, 0, "N", ["M"])
      assert :error = Core.create_probe(0, -1, "N", ["M"])
      assert :error = Core.create_probe(0, 0, "X", ["M"])
      assert :error = Core.create_probe(0, 0, "N", ["Z"])
      assert :error = Core.create_probe(-1, "0", nil, [])
    end
  end

  describe "set_probe_in_highland/2" do
    test "should push a probe in highland" do
      {:ok, highland} = Core.create_highland(0, 0)
      {:ok, probe} = Core.create_probe(0, 0, "N", ["M"])

      assert Enum.empty?(highland.probes) == true
      assert {:ok, %Highland{} = highland} = Core.set_probe_in_highland(highland, probe)
      assert Enum.empty?(highland.probes) == false
      assert [probe] = highland.probes
    end
  end

  describe "perform_next_action/2" do
    test "should perform next action of received probe" do
      {:ok, highland} = Core.create_highland(0, 1)
      {:ok, probe} = Core.create_probe(0, 0, "N", ["M"])
      {:ok, highland} = Core.set_probe_in_highland(highland, probe)

      assert {:ok, %Highland{} = highland} = Core.perform_next_action(highland, probe)

      probe = List.first(highland.probes)

      assert probe.column == 1
      assert Enum.empty?(probe.actions) == true
    end

    test "should not performs probe action when all probe actions have been completed" do
      {:ok, highland} = Core.create_highland(0, 1)
      {:ok, probe} = Core.create_probe(0, 0, "N", ["M"])
      {:ok, highland} = Core.set_probe_in_highland(highland, probe)
      {:ok, %Highland{probes: [probe]}} = Core.perform_next_action(highland, probe)

      assert {:error, %Highland{probes: [probe]}} = Core.perform_next_action(highland, probe)
    end
  end

  # describe "all_probe_actions_have_been_completed/1" do

  # end
end
