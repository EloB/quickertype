require "json"

class TopLevel
  include JSON::Serializable

  @[JSON::Field(key: "user-agent")]
  property user_agent : String
end
