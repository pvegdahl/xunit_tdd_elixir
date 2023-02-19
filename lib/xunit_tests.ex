defmodule Xunit.Tests do
  def main(_argv) do
    Xunit.run_function(&test_can_run_function/0)
    Xunit.run_function(&test_assert_equal_raises_on_unequal/0)
    Xunit.run_function(&test_assert_equal_does_not_raise_on_equal/0)
    Xunit.run_function(&test_print_on_success/0)
    Xunit.run_function(&test_print_on_failure/0)
  end

  def test_can_run_function() do
    try do
      Xunit.run_function(fn -> raise "Expected" end)
      IO.puts("FAILURE")
    rescue
      _e in RuntimeError -> :ok
    end
  end

  def test_assert_equal_raises_on_unequal() do
    try do
      Xunit.assert_equal(1, 2)
      IO.puts("FAILURE")
    rescue
      _e in Xunit.Failure -> :ok
    end
  end

  def test_assert_equal_does_not_raise_on_equal() do
    try do
      Xunit.assert_equal(1, 1)
    rescue
      _e in Xunit.Failure -> IO.puts("FAILURE")
    end
  end

  def test_print_on_success() do
    Xunit.run_function_helper(fn -> :ok end)
    |> Xunit.assert_equal("SUCCESS")
  end

  def test_print_on_failure() do
    Xunit.run_function_helper(fn -> Xunit.assert_equal(86, 99) end)
    |> Xunit.assert_equal("FAILURE")
  end
end
