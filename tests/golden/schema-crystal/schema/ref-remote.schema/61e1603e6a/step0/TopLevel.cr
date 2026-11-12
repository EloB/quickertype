require "json"

# A recursive class type
class TopLevel
  include JSON::Serializable

  @[JSON::Field(key: "next")]
  property top_level_next : TopLevel?
end
