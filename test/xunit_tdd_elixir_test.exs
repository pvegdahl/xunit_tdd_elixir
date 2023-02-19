defmodule XunitTddElixirTest do
  use ExUnit.Case
  doctest XunitTddElixir

  test "greets the world" do
    assert XunitTddElixir.hello() == :world
  end
end
