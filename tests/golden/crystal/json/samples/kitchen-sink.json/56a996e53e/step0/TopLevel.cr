require "json"

class TopLevel
  include JSON::Serializable

  @[JSON::Field(key: "booleanValue")]
  property boolean_value : Bool

  @[JSON::Field(key: "dateValue")]
  property date_value : String

  @[JSON::Field(key: "differentThings")]
  property different_things : Array(DifferentThingElement)

  @[JSON::Field(key: "doubleValue")]
  property double_value : Float64

  @[JSON::Field(key: "intValue")]
  property int_value : Int64

  @[JSON::Field(key: "mapValue")]
  property map_value : Hash(String, Int64?)

  @[JSON::Field(key: "name with spaces")]
  property name_with_spaces : Nil

  @[JSON::Field(key: "nullValue")]
  property null_value : Nil

  @[JSON::Field(key: "nullableMapValue")]
  property nullable_map_value : Hash(String, Int64?)

  property people : Array(PersonElement)

  property person : PurplePerson

  @[JSON::Field(key: "stringValue")]
  property string_value : String

  property tuples : Array(Array(IntOrString))

  @[JSON::Field(key: "uuidValue")]
  property uuid_value : String
end

class DifferentThingClass
  include JSON::Serializable

  property name : String
end

class PersonElement
  include JSON::Serializable

  @[JSON::Field(key: "intOrString")]
  property int_or_string : IntOrString

  property name : String

  @[JSON::Field(key: "optionalValue")]
  property optional_value : Bool?
end

class PurplePerson
  include JSON::Serializable

  @[JSON::Field(key: "intOrString")]
  property int_or_string : Int64

  property name : String
end

alias DifferentThingElement = DifferentThingClass | Int64 | String

alias IntOrString = Int64 | String
