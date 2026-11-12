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

  property coordinates : Array(Float64)

  @[JSON::Field(key: "type")]
  property geometry_type : String
end

class FeatureProperties
  include JSON::Serializable

  property division : String

  property fax : Float64

  property fire_ban_r : String?

  property latitude : Float64

  property local_govt : String

  property longitude : Float64

  property no : String?

  property phone : Float64

  property postcode : Int64

  @[JSON::Field(key: "type")]
  property properties_type : String?

  property psa : String

  property region : String

  property station : String

  property street : String

  property suburb : String
end
