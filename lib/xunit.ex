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
    test_function.()
  end

  def assert_equal(_expected, _actual) do
    raise Xunit.Failure
  end
end
