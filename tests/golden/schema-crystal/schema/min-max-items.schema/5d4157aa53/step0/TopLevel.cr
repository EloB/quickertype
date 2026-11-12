require "json"

class TopLevel
  include JSON::Serializable

  @[JSON::Field(key: "maxOnly")]
  property max_only : Array(Int64)

  @[JSON::Field(key: "minAndMax")]
  property min_and_max : Array(Float64)

  @[JSON::Field(key: "minOnly")]
  property min_only : Array(String)

  property plain : Array(String)

  @[JSON::Field(key: "unionItems")]
  property union_items : Array(UnionItem)
end

alias UnionItem = Int64 | String
