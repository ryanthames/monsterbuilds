defmodule MonsterBuilder do
  @moduledoc """
  Documentation for MonsterBuilder.
  """

  @bloat_values %{
    sword_and_shield: 1.4,
    dual_blades: 1.4,
    greatsword: 4.8,
    longsword: 3.3,
    hammer: 5.2,
    gunlance: 2.3,
    lance: 2.3,
    hunting_horn: 4.2,
    switch_axe: 3.5,
    charge_blade: 3.6,
    insect_glaive: 3.1,
    bow: 1.2,
    heavy_bowgun: 1.5,
    light_bowgun: 1.3
  }

  @sharpness_values %{
    purple: 1.39,
    white: 1.32,
    blue: 1.2,
    green: 1.05,
    yellow: 1.0,
    brown: 0.75,
    red: 0.5
  }

  @doc """
  Hello world.

  ## Examples

      iex> MonsterBuilder.hello()
      :world

  """
  def hello do
    :world
  end

  def calculate_efr_for_build(build) do
    true_raw = get_true_raw(build["weapon"])
    crit_mod = get_crit_mod(build)
    sharpness = @sharpness_values[convert_to_lowercase_atom(build["weapon"]["sharpness"])]
    efr = true_raw * crit_mod * sharpness

    {:ok, build["name"], efr}
  end

  def get_true_raw(weapon) do
    weapon_type = convert_to_lowercase_atom(weapon["weaponType"])
    weapon["rawDamage"] / @bloat_values[weapon_type]
  end

  def get_crit_mod(build) do
    affinity = build["weapon"]["affinity"]
    true_affinity = if (affinity < 0), do: 0, else: affinity

    ((build["critMod"] - 1) * true_affinity) + 1
  end

  def convert_to_lowercase_atom(s) do
    s |> String.downcase |> String.to_atom
  end
end
