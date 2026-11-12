require "json"

class TopLevel
  include JSON::Serializable

  property foo : FooUnion?
end

class FooClass
  include JSON::Serializable

  property bar : Int64
end

alias FooUnion = Float64 | FooClass | Int64 | Array(Int64) | Bool | String
