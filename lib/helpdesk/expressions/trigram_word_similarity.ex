defmodule Helpdesk.Expressions.TrigramWordSimilarity do
  @moduledoc false

  use Ash.CustomExpression,
    name: :trigram_word_similarity,
    arguments: [[:string, :string]],
    predicate?: true

  def expression(data_layer, [left, right])
      when data_layer in [AshPostgres.DataLayer] do
    {:ok, expr(fragment("word_similarity(?, ?)", ^left, ^right))}
  end

  def expression(_data_layer, _args), do: :unknown
end
