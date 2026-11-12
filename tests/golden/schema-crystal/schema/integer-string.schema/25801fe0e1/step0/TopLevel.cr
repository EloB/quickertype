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

  @[JSON::Field(key: "unionWithInt")]
  property union_with_int : UnionWithInt

  @[JSON::Field(key: "unionWithIntAndEnum")]
  property union_with_int_and_enum : UnionWithInt
end

alias UnionWithInt = Int64 | String
