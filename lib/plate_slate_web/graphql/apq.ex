defmodule PlateSlateWeb.Graphql.Apq do
  @moduledoc """
  Sample usage using `curl`


  curl --get http://localhost:4000/graphiql \
  --header 'content-type: application/json' \
  --data-urlencode 'query={menuItems(first: 3) { edges { node { id } }}}' \
  --data-urlencode 'extensions={"persistedQuery":{"version":1,"sha256Hash":"799fdfc59dd9aa8362811674e61fcaf36c0b70e3af321499b9605662e5048d85"}}'


  curl --get http://localhost:4000/graphiql \
  --header 'content-type: application/json' \
  --data-urlencode 'extensions={"persistedQuery":{"version":1,"sha256Hash":"799fdfc59dd9aa8362811674e61fcaf36c0b70e3af321499b9605662e5048d85"}}'


  Sha256 generator: https://tools.keycdn.com/sha256-online-generator
  """

  use Apq.DocumentProvider,
    cache_provider: PlateSlate.Cachex.Cache,
    max_query_size: 16384,
    json_codec: Jason
end
