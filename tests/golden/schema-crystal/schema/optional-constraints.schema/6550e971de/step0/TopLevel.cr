require "json"

class TopLevel
  include JSON::Serializable

  @[JSON::Field(key: "optDouble")]
  property opt_double : Float64?

  @[JSON::Field(key: "optInt")]
  property opt_int : Int64?

  @[JSON::Field(key: "optPattern")]
  property opt_pattern : String?

  @[JSON::Field(key: "optString")]
  property opt_string : String?

  @[JSON::Field(key: "reqZeroMin")]
  property req_zero_min : Int64
end
