defmodule Xunit.Tests do
  def main(_argv) do
    test_can_run_function()
  end

  def test_can_run_function() do
    try do
      Xunit.run_function(fn -> raise "Expected" end)
      IO.puts("FAILURE")
    rescue
      _e in RuntimeError -> IO.puts("SUCCESS")
    end
  end
end
