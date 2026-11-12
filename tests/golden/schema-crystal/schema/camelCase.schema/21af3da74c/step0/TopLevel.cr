require "json"

class TopLevel
  include JSON::Serializable

  @[JSON::Field(key: "myProperty")]
  property my_property : String?

  @[JSON::Field(key: "secondProperty")]
  property second_property : String?
end
