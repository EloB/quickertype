require "json"

class TopLevel
  include JSON::Serializable

  @[JSON::Field(key: "enum")]
  property top_level_enum : String?
end
