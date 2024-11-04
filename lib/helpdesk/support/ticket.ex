defmodule Helpdesk.Support.Ticket do
  @moduledoc false

  use Ash.Resource,
    domain: Helpdesk.Support,
    data_layer: AshPostgres.DataLayer

  postgres do
    repo(Helpdesk.Repo)
    table("support__ticket")
  end

  calculations do
    calculate :name_trigram_relevance,
              :float,
              expr(trigram_word_similarity(name, ^arg(:name))) do
      argument(:name, :string, allow_nil?: false)
    end

    calculate :has_name_like,
              :boolean,
              expr(name_trigram_relevance(name: ^arg(:name)) > 0.2) do
      argument(:name, :string, allow_nil?: false)
    end
  end

  attributes do
    integer_primary_key(:id)
    timestamps()

    attribute :name, :string do
      allow_nil?(false)
      public?(true)
    end
  end

  actions do
    default_accept([:*])
    defaults([:read, :create])

    # Perform the boolean comparison in a calculation
    read :boolean_in_calculation do
      argument(:name, :string, do: allow_nil?(false))

      filter(expr(has_name_like(name: ^arg(:name))))
    end

    read :boolean_in_action_using_calculation do
      argument(:name, :string, do: allow_nil?(false))

      filter(expr(name_trigram_relevance(name: ^arg(:name)) > 0.2))
    end

    read :boolean_in_action_using_ash_expression do
      argument(:name, :string, do: allow_nil?(false))

      filter(expr(trigram_word_similarity(name, ^arg(:name)) > 0.2))
    end
  end
end
