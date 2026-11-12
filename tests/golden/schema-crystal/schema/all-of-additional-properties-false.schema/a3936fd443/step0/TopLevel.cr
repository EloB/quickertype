require "json"

class TopLevel
  include JSON::Serializable

  property amount : Float64

  property frequency : String

  property description : String?

  @[JSON::Field(key: "type")]
  property top_level_type : String
end
