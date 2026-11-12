require "json"

class TopLevel
  include JSON::Serializable

  @[JSON::Field(key: "BoolInUnion")]
  property bool_in_union : BoolInUnion

  @[JSON::Field(key: "union")]
  property top_level_union : Array(UnionElement)
end

class BoolInUnion
  include JSON::Serializable

  property a : Bool
end

alias UnionElement = Int64 | Bool
