require "json"

class TopLevel
  include JSON::Serializable

  @[JSON::Field(key: "basePath")]
  property base_path : String

  property definitions : Definitions

  property host : String

  property info : Info

  property paths : Paths

  property produces : Array(String)

  property schemes : Array(String)

  property swagger : String
end

class Definitions
  include JSON::Serializable

  @[JSON::Field(key: "Taxonomy")]
  property taxonomy : Taxonomy
end

class Taxonomy
  include JSON::Serializable

  property properties : Properties
end

class Properties
  include JSON::Serializable

  property annotations : Annotations

  property datatype_properties : Annotations

  property id : Annotations

  property label : Annotations

  @[JSON::Field(key: "type")]
  property properties_type : Annotations

  property sub_class_of : Annotations
end

class Annotations
  include JSON::Serializable

  @[JSON::Field(key: "type")]
  property annotations_type : String

  property description : String
end

class Info
  include JSON::Serializable

  property description : String

  property title : String

  property version : String
end

class Paths
  include JSON::Serializable

  @[JSON::Field(key: "/ita_taxonomies/search")]
  property ita_taxonomies_search : ItaTaxonomiesSearch
end

class ItaTaxonomiesSearch
  include JSON::Serializable

  property get : Get
end

class Get
  include JSON::Serializable

  property description : String

  property parameters : Array(Parameter)

  property responses : Responses

  property summary : String

  property tags : Array(String)
end

class Parameter
  include JSON::Serializable

  property description : String

  property format : String

  property name : String

  @[JSON::Field(key: "in")]
  property parameter_in : String

  @[JSON::Field(key: "type")]
  property parameter_type : String

  property required : Bool
end

class Responses
  include JSON::Serializable

  @[JSON::Field(key: "200")]
  property the_200 : The200
end

class The200
  include JSON::Serializable

  property description : String

  property schema : Schema
end

class Schema
  include JSON::Serializable

  @[JSON::Field(key: "$ref")]
  property ref : String
end
