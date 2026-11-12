require "json"

class TopLevel
  include JSON::Serializable

  property free : Int64

  property intersection : Int64

  property max : Int64

  property min : Int64

  property minmax : Int64

  @[JSON::Field(key: "minMaxIntersection")]
  property min_max_intersection : Int64

  @[JSON::Field(key: "minMaxUnion")]
  property min_max_union : Int64

  @[JSON::Field(key: "union")]
  property top_level_union : Int64
end
