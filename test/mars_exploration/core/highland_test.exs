defmodule MarsExploration.Core.HighlandTest do
  use ExUnit.Case

  alias MarsExploration.Core.Highland

  describe "new/1" do
    @valid_params [
      %{column: 0, line: 0},
      %{column: :rand.uniform(100), line: :rand.uniform(100)},
      %{column: :rand.uniform(100), line: :rand.uniform(100)},
      %{column: :rand.uniform(100), line: :rand.uniform(100)}
    ]

    @invalid_params [
      Map.new(),
      %{probes: nil, column: nil, line: nil},
      %{column: nil, line: nil},
      %{column: nil},
      %{column: "nil", line: "2"},
      %{column: [], line: -1},
      %{column: -12, line: :rand.uniform(100)}
    ]

    test "must return a highland when receiving valid parameters" do
      Enum.each(@valid_params, fn params ->
        highland = Highland.new(params)

        assert %Highland{} = highland
        assert Enum.empty?(highland.probes)
        assert highland.column == params.column
        assert highland.line == params.line
      end)
    end

    test "must raise a ArgumentError when receiving invalid parameters" do
      Enum.each(@invalid_params, fn params ->
        assert_raise ArgumentError, "Invalid params", fn -> Highland.new(params) end
      end)
    end
  end

  describe "push_probe/2" do
    alias MarsExploration.Core.Probe

    @highland_params %{column: 0, line: 0}
    @valid_probe_param %{direction: "N", column: 0, line: 0}
    @invalid_probe_params [
      %{direction: "N", column: 2, line: 2},
      %{direction: "N", column: 1, line: 2},
      %{direction: "N", column: 2, line: 1}
    ]

    setup do
      highland = Highland.new(@highland_params)
      {:ok, highland: highland}
    end

    test "must push a probe when highland don't have a probe", %{highland: highland} do
      probe = Probe.new(@valid_probe_param)

      assert {:ok, %Highland{probes: [probe] = probes}} = Highland.push_probe(highland, probe)
      assert Enum.empty?(probes) == false
      assert length(probes) == 1
    end

    test "mush returns a error when try to push a probe with not exist position in highland", %{
      highland: highland
    } do
      Enum.each(@invalid_probe_params, fn params ->
        probe = Probe.new(params)

        assert {:error, %Highland{probes: probes} = highland} =
                 Highland.push_probe(highland, probe)

        assert Enum.empty?(probes) == true
      end)
    end

    test "must returns a error when try to psuh a probe in position occupied in highland", %{
      highland: highland
    } do
      probe1 = Probe.new(@valid_probe_param)
      probe2 = Probe.new(@valid_probe_param)

      {:ok, highland} = Highland.push_probe(highland, probe1)

      assert {:error, %Highland{probes: [probe1] = probes}} =
               Highland.push_probe(highland, probe2)

      assert Enum.empty?(probes) == false
      assert length(probes) == 1
    end
  end

  describe "has_probe_in_position?/3" do
    alias MarsExploration.Core.Probe

    @highland_params %{column: 0, line: 0}
    @probe_param %{direction: "N", column: 0, line: 0}

    setup do
      highland = Highland.new(@highland_params)
      probe = Probe.new(@probe_param)

      {:ok, highland: highland, probe: probe}
    end

    test "must returns true when position received has a probe in highland", %{highland: highland, probe: probe} do
      {:ok, highland} = Highland.push_probe(highland, probe)

      assert Highland.has_probe_in_position?(highland, 0, 0) == true
    end

    test "must returns false when position received don't have a probe in highland", %{highland: highland, probe: probe} do
      {:ok, highland} = Highland.push_probe(highland, probe)

      assert Highland.has_probe_in_position?(highland, 1, 1) == false
      assert Highland.has_probe_in_position?(highland, 0, 1) == false
      assert Highland.has_probe_in_position?(highland, 1, 0) == false
    end
  end

  describe "has_position?/3" do
    @highland_params %{column: 5, line: 5}

    setup do
      highland = Highland.new(@highland_params)

      {:ok, highland: highland}
    end

    test "must return true when position received exist in highland boundaries", %{highland: highland} do
      range_positions = 0..5

      for line <- range_positions, column <- range_positions do
        assert Highland.has_position?(highland, column, line) == true
      end
    end

    test "must return false when position received not exist in highland boundaries", %{highland: highland} do
      range_positions = 6..11

      for line <- range_positions, column <- range_positions do
        assert Highland.has_position?(highland, column, line) == false
      end
    end
  end
end
