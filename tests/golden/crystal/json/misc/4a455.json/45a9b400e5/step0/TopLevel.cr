require "json"

class TopLevel
  include JSON::Serializable

  property crs : Crs

  property features : Array(Feature)

  @[JSON::Field(key: "type")]
  property top_level_type : String

  @[JSON::Field(key: "totalFeatures")]
  property total_features : Int64
end

class Crs
  include JSON::Serializable

  @[JSON::Field(key: "type")]
  property crs_type : String

  property properties : CrsProperties
end

class CrsProperties
  include JSON::Serializable

  property name : String
end

class Feature
  include JSON::Serializable

  @[JSON::Field(key: "type")]
  property feature_type : String

  property geometry : Geometry

  property geometry_name : String

  property id : String

  property properties : FeatureProperties
end

class Geometry
  include JSON::Serializable

  property coordinates : Array(Array(Float64))

  @[JSON::Field(key: "type")]
  property geometry_type : String
end

class FeatureProperties
  include JSON::Serializable

  property facebookaccount : String

  property frequencyfinderurl : String

  property name : String

  property siteurl : String

  property streetaddress : String

  property twitteraccount : String
end
