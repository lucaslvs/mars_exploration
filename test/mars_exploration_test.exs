defmodule MarsExplorationTest do
  use ExUnit.Case
  doctest MarsExploration

  test "greets the world" do
    assert MarsExploration.hello() == :world
  end
end
