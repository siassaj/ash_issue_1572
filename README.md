# repo to recreate ash-project/ash issues 1572

[https://github.com/ash-project/ash/issues/1572](Link to issue)

# Requirements
- Elixir version: 1.17.2
- Erlang version: Erlang/OTP 27 [erts-15.0.1]
- Postgresql ~> 16

# Setup
1. clone & run `mix deps.get`
1. set env vars for DB;
   - DB_USERNAME (defaults to "postgres")
   - DB_PASSWORD (defaults to "postgres")
   - DB_HOSTNAME (defaults to "localhost")
   - DB_NAME (defaults to "helpdesk")
   - PORT (defaults to "5432")
1. run `mix ash.setup`

# Test
1. run `mix test`

## My results
included in case theres' something about my system causing this

- Elixir 1.17.2
- Erlang/OTP 27 [erts-15.0.1]
- Ubuntu 22.04.5 LTS
- Dockerised PostgreSQL 17rc1 (Debian 17~rc1-1.pgdg120+1) on x86_64-pc-linux-gnu, compiled by gcc (Debian 12.2.0-14) 12.2.0, 64-bit

1 failure
```
  1) test using a boolean and ash expression in an action works (HelpdeskTest)
     test/helpdesk_test.exs:34
     Assertion with == failed
     code:  assert Helpdesk.Support.Ticket
            |> Ash.Query.for_read(:boolean_in_action_using_ash_expression, %{name: "first"})
            |> Ash.read!()
            |> length() == 1
     left:  2
     right: 1
     stacktrace:
       test/helpdesk_test.exs:35: (test)
```
 
failing sql query
```
13:08:40.776 [debug] QUERY OK source="support__ticket" db=0.2ms queue=0.3ms
SELECT s0."id", s0."name", s0."inserted_at", s0."updated_at" FROM "support__ticket" AS s0 []
```
 
passing sql queries

```
# should be for action :boolean_in_action_using_calculation as the result is not cast to boolean
13:08:40.802 [debug] QUERY OK source="support__ticket" db=0.7ms queue=0.4ms
SELECT s0."id", s0."name", s0."inserted_at", s0."updated_at" FROM "support__ticket" AS s0 WHERE ((word_similarity(s0."name"::text, $1))::float > $2::float) ["first", 0.2]

# should be for action :boolean_in_calculation as the result is cast to boolean
13:08:40.808 [debug] QUERY OK source="support__ticket" db=0.6ms queue=0.3ms
SELECT s0."id", s0."name", s0."inserted_at", s0."updated_at" FROM "support__ticket" AS s0 WHERE (((word_similarity(s0."name"::text, $1))::float > $2::float)::boolean) ["first", 0.2]
```
