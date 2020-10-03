defmodule BrwSingleTest do
  use ExUnit.Case
  doctest BrwSingle

  test "greets the world" do
    assert BrwSingle.hello() == :world
  end
end
