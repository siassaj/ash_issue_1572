import Config

config :helpdesk,
  ash_domains: [Helpdesk.Support],
  ecto_repos: [Helpdesk.Repo]

config :ash,
  custom_expressions: [Helpdesk.Expressions.TrigramWordSimilarity]
