defmodule Xunit.Tests do
  def main(_argv) do
    Xunit.run_function(&test_can_run_function/0)
    Xunit.run_function(&test_assert_equal_raises_on_unequal/0)
    Xunit.run_function(&test_assert_equal_does_not_raise_on_equal/0)
    Xunit.run_function(&test_print_on_success/0)
    Xunit.run_function(&test_print_on_failure/0)
  end

  def test_can_run_function() do
    can_run_function_helper()
    |> Xunit.assert_equal(:success)
  end

  defp can_run_function_helper() do
    try do
      Xunit.run_function(fn -> raise "Expected" end)
      :failure
    rescue
      _e in RuntimeError -> :success
    end
  end

  def test_assert_equal_raises_on_unequal() do
    assert_equal_helper(1, 2)
    |> Xunit.assert_equal(:unequal)
  end

  defp assert_equal_helper(a, b) do
    try do
      Xunit.assert_equal(a, b)
      :equal
    rescue
      _e in Xunit.Failure -> :unequal
    end
  end

  def test_assert_equal_does_not_raise_on_equal() do
    assert_equal_helper(1, 1)
    |> Xunit.assert_equal(:equal)
  end

  def test_print_on_success() do
    Xunit.run_function_helper(&passing_function/0)
    |> Xunit.assert_equal("[SUCCESS] passing_function")
  end

  defp passing_function(), do: Xunit.assert_equal(24601, 24601)

  def test_print_on_failure() do
    Xunit.run_function_helper(&failing_function/0)
    |> Xunit.assert_equal("FAILURE")
  end

  defp failing_function(), do: Xunit.assert_equal(86, 99)
end
