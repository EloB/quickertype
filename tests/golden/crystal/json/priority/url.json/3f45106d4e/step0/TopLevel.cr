require "json"

class TopLevel
  include JSON::Serializable

  @[JSON::Field(key: "fromURL")]
  property from_url : String

  property url : String
end
