require "json"

class TopLevel
  include JSON::Serializable

  @[JSON::Field(key: "arrNullable")]
  property arr_nullable : Array(String?)?

  @[JSON::Field(key: "arrOne")]
  property arr_one : Array(String)?

  property nullable : String?

  property one : String

  property optional : String?

  @[JSON::Field(key: "unionWithEnum")]
  property union_with_enum : String
end
