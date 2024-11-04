defmodule Helpdesk.Support do
  @moduledoc false

  use Ash.Domain

  resources do
    resource(Helpdesk.Support.Ticket)
  end
end
