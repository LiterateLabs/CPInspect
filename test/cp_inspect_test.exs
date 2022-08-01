defmodule ColorProcessInspectTest do
  use ExUnit.Case
  doctest ColorProcessInspect

  test "inits the CPIGenServer" do
    assert CPIGenServer.init(%{test: :one}) == {:ok, %{test: :one}}
  end
end
