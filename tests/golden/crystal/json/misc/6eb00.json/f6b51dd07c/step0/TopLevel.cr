require "json"

alias TopLevel = Array(TopLevelElement)

class TopLevelElement
  include JSON::Serializable

  @[JSON::Field(key: "DirectorateID")]
  property directorate_id : Int64

  @[JSON::Field(key: "Id")]
  property id : Int64

  @[JSON::Field(key: "Name")]
  property name : String
end
