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

  @[JSON::Field(key: "Provider")]
  property provider : Provider
end

class Provider
  include JSON::Serializable

  property properties : Hash(String, Property)
end

class Property
  include JSON::Serializable

  property description : String

  @[JSON::Field(key: "type")]
  property property_type : String
end

class Info
  include JSON::Serializable

  property description : String

  property title : String

  property version : String
end

class Paths
  include JSON::Serializable

  @[JSON::Field(key: "/business_service_providers/search")]
  property business_service_providers_search : BusinessServiceProvidersSearch
end

class BusinessServiceProvidersSearch
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
