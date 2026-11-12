require "json"

class TopLevel
  include JSON::Serializable

  property foo : FooUnion
end

alias FooUnion = Float64 | Bool | String
