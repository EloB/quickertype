require "json"

class TopLevel
  include JSON::Serializable

  property features : Array(Feature)

  property name : String

  @[JSON::Field(key: "type")]
  property top_level_type : String
end

class Feature
  include JSON::Serializable

  @[JSON::Field(key: "type")]
  property feature_type : String

  property geometry : Geometry

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

  @[JSON::Field(key: "Area")]
  property area : String

  @[JSON::Field(key: "Central Asset ID")]
  property central_asset_id : String

  @[JSON::Field(key: "Feature Location")]
  property feature_location : String

  property lat : String

  property long : String

  @[JSON::Field(key: "Maintaining Authority")]
  property maintaining_authority : String

  @[JSON::Field(key: "Number")]
  property number : String

  @[JSON::Field(key: "Class")]
  property properties_class : String

  @[JSON::Field(key: "Site Name")]
  property site_name : String

  @[JSON::Field(key: "Ward")]
  property ward : String
end
