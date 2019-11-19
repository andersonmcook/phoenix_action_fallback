# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Paf.Repo.insert!(%Paf.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
{:ok, _} = Paf.Accounts.create_user(%{age: 20, name: "Young"})
{:ok, _} = Paf.Accounts.create_user(%{age: 123, name: "Old"})
{:ok, _} = Paf.Accounts.create_user(%{age: 69, name: "Nice"})
