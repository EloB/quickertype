require "json"

class TopLevel
  include JSON::Serializable

  @[JSON::Field(key: "optional-date")]
  property optional_date : String?

  @[JSON::Field(key: "optional-date-time")]
  property optional_date_time : String?

  @[JSON::Field(key: "optional-time")]
  property optional_time : String?

  @[JSON::Field(key: "required-date")]
  property required_date : String

  @[JSON::Field(key: "required-date-time")]
  property required_date_time : String

  @[JSON::Field(key: "required-time")]
  property required_time : String
end
