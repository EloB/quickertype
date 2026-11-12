require "json"

class TopLevel
  include JSON::Serializable

  @[JSON::Field(key: "booleanValue")]
  property boolean_value : Bool

  @[JSON::Field(key: "doubleValue")]
  property double_value : Float64

  @[JSON::Field(key: "intValue")]
  property int_value : Int64

  @[JSON::Field(key: "stringValue")]
  property string_value : String

  @[JSON::Field(key: "uuidValue")]
  property uuid_value : String

  @[JSON::Field(key: "uuidValues")]
  property uuid_values : Array(String)
end
