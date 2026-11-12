require "json"

class TopLevel
  include JSON::Serializable

  property bbox : Array(Float64)

  property features : Array(Feature)

  property metadata : Metadata

  @[JSON::Field(key: "type")]
  property top_level_type : String
end

class Feature
  include JSON::Serializable

  @[JSON::Field(key: "type")]
  property feature_type : String

  property geometry : Geometry

  property id : String

  property properties : Properties
end

class Geometry
  include JSON::Serializable

  property coordinates : Array(Float64)

  @[JSON::Field(key: "type")]
  property geometry_type : String
end

class Properties
  include JSON::Serializable

  property alert : Nil

  property cdi : Nil

  property code : String

  property detail : String

  property dmin : Float64?

  property felt : Nil

  property gap : Int64?

  property ids : String

  property mag : Float64

  @[JSON::Field(key: "magType")]
  property mag_type : String

  property mmi : Nil

  property net : String

  property nst : Int64?

  property place : String

  @[JSON::Field(key: "type")]
  property properties_type : String

  property rms : Float64

  property sig : Int64

  property sources : String

  property status : String

  property time : Int64

  property title : String

  property tsunami : Int64

  property types : String

  property tz : Int64

  property updated : Int64

  property url : String
end

class Metadata
  include JSON::Serializable

  property api : String

  property count : Int64

  property generated : Int64

  property status : Int64

  property title : String

  property url : String
end
