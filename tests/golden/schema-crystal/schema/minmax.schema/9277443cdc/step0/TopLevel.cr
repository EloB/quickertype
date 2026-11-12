require "json"

class TopLevel
  include JSON::Serializable

  property free : Float64

  property intersection : Float64

  property max : Float64

  property min : Float64

  property minmax : Float64

  @[JSON::Field(key: "minMaxIntersection")]
  property min_max_intersection : Float64

  @[JSON::Field(key: "minMaxUnion")]
  property min_max_union : Float64

  @[JSON::Field(key: "union")]
  property top_level_union : Float64
end
