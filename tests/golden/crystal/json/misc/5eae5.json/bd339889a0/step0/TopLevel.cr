require "json"

alias TopLevel = Array(TopLevelElement)

class TopLevelElement
  include JSON::Serializable

  @[JSON::Field(key: "Date")]
  property date : String

  @[JSON::Field(key: "ID")]
  property id : Int64

  @[JSON::Field(key: "Sponsor")]
  property sponsor : String

  @[JSON::Field(key: "Title")]
  property title : String
end
