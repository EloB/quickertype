require "json"

class TopLevel
  include JSON::Serializable

  property arr : Array(Arr)?

  @[JSON::Field(key: "for")]
  property top_level_for : String?

  property gve : String

  property lvc : String?

  @[JSON::Field(key: "otherArr")]
  property other_arr : Array(String)?
end

alias Arr = Int64 | String
