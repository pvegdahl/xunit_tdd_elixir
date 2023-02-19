defmodule Xunit do
  @moduledoc """
  Documentation for `XunitTddElixir`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> XunitTddElixir.hello()
      :world

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
      e in Xunit.Failure -> "[FAILURE] #{get_function_name(test_function)}: #{Exception.message(e)}"
    end
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
