# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Lunaris.Repo.insert!(%Lunaris.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

Lunaris.Repo.insert(%Lunaris.Customers.Customer{
  phone: "",
  email: "example@lunaris.jp",
  balance: 0.0
})

Lunaris.Repo.insert(%Lunaris.Customers.Customer{
  email: "deviprsd21@yahoo.com",
  phone: "",
  balance: 0.0
})

Lunaris.Repo.insert(%Lunaris.Customers.Customer{phone: "8482481254", email: "", balance: 0.0})
