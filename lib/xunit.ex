defmodule Xunit do
  @moduledoc """
  This is a learning project.  I used TDD to write a unit test framework, and used the same
  framework to test itself while building it.  This is a fun exercise, and you can learn a lot both
  about TDD and the details of a language.
  """
  def run_function(test_function) do
    run_function_helper(test_function)
    |> IO.puts()
  end

  def run_function_helper(test_function) do
    try do
      test_function.()
      "[SUCCESS] #{get_function_name(test_function)}"
    rescue
      e in Xunit.Failure ->
        "[FAILURE] #{get_function_name(test_function)}: #{Exception.message(e)}"

      e in RuntimeError ->
        "[EXCEPTION] #{get_function_name(test_function)}: #{Exception.message(e)}"
    end
  end

  def run_module(test_module) do
    run_module_helper(test_module)
    |> Enum.each(&IO.puts/1)
  end

  def run_module_helper(test_module) do
    test_module.__info__(:functions)
    |> Enum.filter(&is_test_function?/1)
    |> Enum.map(fn {name, arity} -> Function.capture(test_module, name, arity) end)
    |> Enum.map(fn func -> run_function_helper(func) end)
  end

  defp is_test_function?({name, arity}) do
    is_test_name =
      name
      |> Atom.to_string()
      |> String.starts_with?("test")

    is_zero_arity = arity == 0

    is_test_name and is_zero_arity
  end

  defp get_function_name(function) do
    function
    |> Function.info(:name)
    |> elem(1)
    |> Atom.to_string()
    |> String.replace_leading("-fun.", "")
    |> String.replace_trailing("/0-", "")
  end

  def assert_equal(actual, expected)
  def assert_equal(x, x), do: :ok

  def assert_equal(actual, expected) do
    raise Xunit.Failure, message: "Expected #{expected}, got #{actual}"
  end
end
