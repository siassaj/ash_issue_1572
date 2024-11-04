import Config

config :helpdesk, Helpdesk.Repo,
  show_sensitive_data_on_connection_error: true,
  username: System.get_env("DB_USERNAME", "postgres"),
  password: System.get_env("DB_PASSWORD", "postgres"),
  hostname: System.get_env("DB_HOSTNAME", "localhost"),
  database: System.get_env("DB_NAME", "helpdesk"),
  port: String.to_integer(System.get_env("DB_PORT", "5432")),
  pool: Ecto.Adapters.SQL.Sandbox
