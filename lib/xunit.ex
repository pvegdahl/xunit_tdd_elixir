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
  end

  def run_function_helper(test_function) do
    test_function.()
  end

  def assert_equal(expected, actual)
  def assert_equal(x, x), do: :ok
  def assert_equal(_expected, _actual) do
    raise Xunit.Failure
  end
end
