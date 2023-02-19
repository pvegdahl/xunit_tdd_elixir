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
      "SUCCESS"
    rescue
      _e in Xunit.Failure -> "FAILURE"
    end
  end

  def assert_equal(actual, expected)
  def assert_equal(x, x), do: :ok
  def assert_equal(_actual, _expected) do
    raise Xunit.Failure
  end
end
