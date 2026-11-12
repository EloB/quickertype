require "json"

class TopLevel
  include JSON::Serializable

  property data : Int64

  @[JSON::Field(key: "next")]
  property top_level_next : TopLevel?
end
