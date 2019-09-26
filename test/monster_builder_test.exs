defmodule MonsterBuilderTest do
  use ExUnit.Case
  doctest MonsterBuilder

  test "greets the world" do
    assert MonsterBuilder.hello() == :world
  end

  test "calculates EFR for some builds" do
    get_json("gunlance.json")
    |> Enum.each(&(IO.inspect MonsterBuilder.calculate_efr_for_build(&1)))
    assert true
  end

  defp get_json(filename) do
    filename
    |> File.read!
    |> Poison.decode!
  end
end
