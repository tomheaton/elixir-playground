defmodule Simple do
  @moduledoc """
  This is the Simple module.
  """
  @moduledoc since: "1.0.0"

  @doc """
  Says hello.

  Returns `:ok`.

  ## Examples

      iex> Simple.hello()
      :ok

  """
  @doc since: "1.3.0"
  def hello do
    IO.puts("hello")
  end
end
