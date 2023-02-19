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
end
