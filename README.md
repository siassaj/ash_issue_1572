# repo to recreate ash-project/ash issues 1572

[https://github.com/ash-project/ash/issues/1572](Link to issue)

# Requirements
Elixir version: 1.17.2
Erlang version: Erlang/OTP 27 [erts-15.0.1]
Postgresql ~> 16

# Setup
1. clone & run `mix deps.get`
1. set env vars for DB;
   - DB_USERNAME (defaults to "postgres")
   - DB_PASSWORD (defaults to "postgres")
   - DB_HOSTNAME (defaults to "localhost")
   - DB_NAME (defaults to "helpdesk")
1. run `mix ash.setup`

# Test
1. run `mix test`


