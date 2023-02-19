defmodule Xunit.Tests do
  def main(_argv) do
    Xunit.run_function(&test_can_run_function/0)
    Xunit.run_function(&test_assert_equal_raises_on_unequal/0)
    Xunit.run_function(&test_assert_equal_does_not_raise_on_equal/0)
    Xunit.run_function(&test_print_on_success/0)
  end

  def test_can_run_function() do
    try do
      Xunit.run_function(fn -> raise "Expected" end)
      IO.puts("FAILURE")
    rescue
      _e in RuntimeError -> IO.puts("SUCCESS")
    end
  end

  def test_assert_equal_raises_on_unequal() do
    try do
      Xunit.assert_equal(1, 2)
      IO.puts("FAILURE")
    rescue
      _e in Xunit.Failure -> IO.puts("SUCCESS")
    end
  end

  def test_assert_equal_does_not_raise_on_equal() do
    try do
      Xunit.assert_equal(1, 1)
      IO.puts("SUCCESS")
    rescue
      _e in Xunit.Failure -> IO.puts("FAILURE")
    end
  end

  def test_print_on_success() do
    Xunit.run_function_helper(fn -> :ok end)
    |> Xunit.assert_equal("SUCCESS")
    IO.puts("SUCCESS")
  end
end
