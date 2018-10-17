defmodule Pow.Store.Backend.EtsCacheTest do
  use ExUnit.Case
  doctest Pow.Store.Backend.EtsCache

  alias Pow.{Config, Store.Backend.EtsCache}

  @default_config [namespace: "pow:test", ttl: :timer.hours(1)]

  test "can put, get and delete records" do
    assert EtsCache.get(@default_config, "key") == :not_found

    EtsCache.put(@default_config, "key", "value")
    :timer.sleep(100)
    assert EtsCache.get(@default_config, "key") == "value"

    EtsCache.delete(@default_config, "key")
    :timer.sleep(100)
    assert EtsCache.get(@default_config, "key") == :not_found
  end

  test "fetch keys" do
    EtsCache.put(@default_config, "key1", "value")
    EtsCache.put(@default_config, "key2", "value")
    :timer.sleep(100)

    assert Enum.sort(EtsCache.keys(@default_config)) == ["pow:test:key1", "pow:test:key2"]
  end

  test "records auto purge" do
    config = Config.put(@default_config, :ttl, 100)

    EtsCache.put(config, "key", "value")
    :timer.sleep(50)
    assert EtsCache.get(config, "key") == "value"
    :timer.sleep(100)
    assert EtsCache.get(config, "key") == :not_found
  end
end
