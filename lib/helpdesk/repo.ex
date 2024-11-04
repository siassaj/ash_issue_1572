defmodule Helpdesk.Repo do
  @moduledoc false

  use AshPostgres.Repo, otp_app: :helpdesk

  @spec installed_extensions() :: [String.t()]
  def installed_extensions do
    # Ash installs some functions that it needs to run the
    # first time you generate migrations.
    ["citext", "ash-functions", "pg_trgm"]
  end

  def min_pg_version do
    %Version{major: 16, minor: 0, patch: 0}
  end
end
