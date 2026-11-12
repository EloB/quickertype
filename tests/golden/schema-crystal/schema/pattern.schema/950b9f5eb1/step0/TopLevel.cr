require "json"

class TopLevel
  include JSON::Serializable

  property pattern1 : String

  property pattern2 : String

  @[JSON::Field(key: "RegExp")]
  property reg_exp : RegExp?

  @[JSON::Field(key: "union")]
  property top_level_union : String
end

class RegExp
  include JSON::Serializable

  property pattern3 : String
end
