defmodule MarsExploration.HighlandTest do
  use ExUnit.Case

  alias MarsExploration.Highland

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
end
