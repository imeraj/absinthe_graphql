defmodule PlateSlate.Cachex.Cache do
  @behaviour Apq.CacheProvider

  def get(hash) do
    Cachex.get(:apq_cache, hash)
  end

  def put(hash, query) do
    Cachex.put(:apq_cache, hash, query)
  end
end
