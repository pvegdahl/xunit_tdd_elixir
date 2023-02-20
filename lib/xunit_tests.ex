defmodule Xunit.Tests do
  def main(_argv) do
    Xunit.run_function(&test_assert_equal_raises_on_unequal/0)
    Xunit.run_function(&test_assert_equal_does_not_raise_on_equal/0)
    Xunit.run_function(&test_print_on_success/0)
    Xunit.run_function(&test_print_on_failure/0)
    Xunit.run_function(&test_print_other_exceptions/0)
    Xunit.run_function(&test_run_all_functions_in_a_module/0)
    Xunit.run_function(&test_skip_non_test_functions_in_module/0)
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
    |> Xunit.assert_equal("[FAILURE] failing_function: Expected 99, got 86")
  end

  defp failing_function(), do: Xunit.assert_equal(86, 99)

  def test_print_other_exceptions() do
    Xunit.run_function_helper(&exception_function/0)
    |> Xunit.assert_equal("[EXCEPTION] exception_function: Oh no")
  end

  defp exception_function(), do: raise "Oh no"

  def test_run_all_functions_in_a_module() do
    Xunit.run_module_helper(TestRunAllFunctions)
    |> Xunit.assert_equal(["[FAILURE] test_fail: Expected 3, got 2", "[SUCCESS] test_pass"])
  end

  def test_skip_non_test_functions_in_module() do
    Xunit.run_module_helper(TestSkipNonTestFunctions)
    |> Xunit.assert_equal(["[SUCCESS] test_pass"])
  end
end

defmodule TestRunAllFunctions do
  def test_pass(), do: Xunit.assert_equal(1, 1)
  def test_fail(), do: Xunit.assert_equal(2, 3)
end

defmodule TestSkipNonTestFunctions do
  def test_pass(), do: Xunit.assert_equal(1, 1)
  def something_else(), do: :ok
end

# TODO
# Run all test functions in a module
# Do not run non-test functions in a module
# Do not run functions with arity != 0
