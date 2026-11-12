require "json"

class TopLevel
  include JSON::Serializable

  property birthday : String

  @[JSON::Field(key: "lastSeen")]
  property last_seen : String

  property name : String
end
