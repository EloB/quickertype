require "json"

class TopLevel
  include JSON::Serializable

  property intersection : String

  @[JSON::Field(key: "inUnion")]
  property in_union : InUnion

  property maxlength : String

  property minlength : String

  @[JSON::Field(key: "minMaxIntersection")]
  property min_max_intersection : String

  property minmaxlength : String

  @[JSON::Field(key: "minMaxUnion")]
  property min_max_union : String

  @[JSON::Field(key: "union")]
  property top_level_union : String
end

alias InUnion = Float64 | String
