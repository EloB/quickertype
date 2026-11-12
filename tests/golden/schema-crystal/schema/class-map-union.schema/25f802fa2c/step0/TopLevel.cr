require "json"

class TopLevel
  include JSON::Serializable

  @[JSON::Field(key: "union")]
  property top_level_union : Hash(String, UnionValue)?
end

class UnionClass
  include JSON::Serializable

  property quux : Int64?
end

alias UnionValue = Float64 | Bool | String | UnionClass
