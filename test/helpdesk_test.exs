defmodule HelpdeskTest do
  use ExUnit.Case
  doctest Helpdesk

  setup tags do
    pid = Ecto.Adapters.SQL.Sandbox.start_owner!(Helpdesk.Repo, shared: not tags[:async])
    on_exit(fn -> Ecto.Adapters.SQL.Sandbox.stop_owner(pid) end)

    Helpdesk.Support.Ticket
    |> Ash.Changeset.for_create(:create, %{name: "first"})
    |> Ash.create!()

    Helpdesk.Support.Ticket
    |> Ash.Changeset.for_create(:create, %{name: "second"})
    |> Ash.create!()

    :ok
  end

  test "using a boolean in a calculation works" do
    assert Helpdesk.Support.Ticket
           |> Ash.Query.for_read(:boolean_in_calculation, %{name: "first"})
           |> Ash.read!()
           |> length() == 1
  end

  test "using a boolean and calculation in an action works" do
    assert Helpdesk.Support.Ticket
           |> Ash.Query.for_read(:boolean_in_action_using_calculation, %{name: "first"})
           |> Ash.read!()
           |> length() == 1
  end

  test "using a boolean and ash expression in an action works" do
    assert Helpdesk.Support.Ticket
           |> Ash.Query.for_read(:boolean_in_action_using_ash_expression, %{name: "first"})
           |> Ash.read!()
           |> length() == 1
  end
end
