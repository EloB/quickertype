require "json"

alias TopLevel = Array(TopLevelElement)

class TopLevelElement
  include JSON::Serializable

  @[JSON::Field(key: "ID")]
  property id : Int64

  @[JSON::Field(key: "Name")]
  property name : String

  @[JSON::Field(key: "Notes")]
  property notes : String
end
