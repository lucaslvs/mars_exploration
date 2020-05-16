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

  # describe "create_probe/4" do

  # end

  # describe "set_probe_in_highland/2" do

  # end

  # describe "perform_next_action/2" do

  # end

  # describe "all_probe_actions_have_been_completed/1" do

  # end
end
