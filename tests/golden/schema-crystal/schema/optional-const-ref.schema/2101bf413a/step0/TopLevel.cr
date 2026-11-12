require "json"

class TopLevel
  include JSON::Serializable

  property coordinates : Array(Coordinate)?

  property count : Int64?

  property label : String?

  @[JSON::Field(key: "requiredCoordinates")]
  property required_coordinates : Array(Coordinate)

  @[JSON::Field(key: "requiredCount")]
  property required_count : Int64

  @[JSON::Field(key: "requiredLabel")]
  property required_label : String

  property weight : Float64?
end

class Coordinate
  include JSON::Serializable

  property latitude : Float64

  property longitude : Float64
end
