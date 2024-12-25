defmodule PlateSlateWeb.Graphql.Types.AllergyInfoType do
  @moduledoc false

  use Absinthe.Schema.Notation

  @desc "Allergy info"
  object :allergy_info do
    field :allergen, :string
    field :severity, :string
  end
end
