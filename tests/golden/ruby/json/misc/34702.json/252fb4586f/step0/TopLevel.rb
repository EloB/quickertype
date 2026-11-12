# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.features.first.properties.division
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry.Types(default: :nominal)

  Integer        = Strict::Integer
  Nil            = Strict::Nil
  Hash           = Strict::Hash
  String         = Strict::String
  Double         = Strict::Float | Strict::Integer
  FeatureType    = Strict::String.enum("Feature")
  GeometryType   = Strict::String.enum("Point")
  GeometryName   = Strict::String.enum("geom")
  FireBanR       = Strict::String.enum("North Central", "Central", "South West", "Wimmera", "Northern Country", "East Gippsland", "North East", "Mallee", "West &South Gippsland", "Ballarat")
  PropertiesType = Strict::String.enum("STREET", "AVENUE", "ROAD", "HIGHWAY", "BOULEVARD", "COURT", "WAY", "DRIVE", "SOUTH", "HILL", "LANE", "CLOSE", "PARADE", "Road", "PLACE", "RD")
  Region         = Strict::String.enum("Eastern", "Northern Metro", "Western", "Southern Metro")
end

class CRSProperties < Dry::Struct
  attribute :properties_name, Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      properties_name: d.fetch("name"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "name" => properties_name,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class CRS < Dry::Struct
  attribute :crs_type,   Types::String
  attribute :properties, CRSProperties

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      crs_type:   d.fetch("type"),
      properties: CRSProperties.from_dynamic!(d.fetch("properties")),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "type"       => crs_type,
      "properties" => properties.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

module FeatureType
  Feature = "Feature"
end

module GeometryType
  Point = "Point"
end

class Geometry < Dry::Struct
  attribute :coordinates,   Types.Array(Types::Double)
  attribute :geometry_type, Types::GeometryType

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      coordinates:   d.fetch("coordinates"),
      geometry_type: d.fetch("type"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "coordinates" => coordinates,
      "type"        => geometry_type,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

module GeometryName
  Geom = "geom"
end

module FireBanR
  NorthCentral       = "North Central"
  Central            = "Central"
  SouthWest          = "South West"
  Wimmera            = "Wimmera"
  NorthernCountry    = "Northern Country"
  EastGippsland      = "East Gippsland"
  NorthEast          = "North East"
  Mallee             = "Mallee"
  WestSouthGippsland = "West &South Gippsland"
  Ballarat           = "Ballarat"
end

module PropertiesType
  Street    = "STREET"
  Avenue    = "AVENUE"
  Road      = "ROAD"
  Highway   = "HIGHWAY"
  Boulevard = "BOULEVARD"
  Court     = "COURT"
  Way       = "WAY"
  Drive     = "DRIVE"
  South     = "SOUTH"
  Hill      = "HILL"
  Lane      = "LANE"
  Close     = "CLOSE"
  Parade    = "PARADE"
  TypeRoad  = "Road"
  Place     = "PLACE"
  RD        = "RD"
end

module Region
  Eastern       = "Eastern"
  NorthernMetro = "Northern Metro"
  Western       = "Western"
  SouthernMetro = "Southern Metro"
end

class FeatureProperties < Dry::Struct
  attribute :division,        Types::String
  attribute :fax,             Types::Double
  attribute :fire_ban_r,      Types::FireBanR.optional
  attribute :latitude,        Types::Double
  attribute :local_govt,      Types::String
  attribute :longitude,       Types::Double
  attribute :no,              Types::String.optional
  attribute :phone,           Types::Double
  attribute :postcode,        Types::Integer
  attribute :properties_type, Types::PropertiesType.optional
  attribute :psa,             Types::String
  attribute :region,          Types::Region
  attribute :station,         Types::String
  attribute :street,          Types::String
  attribute :suburb,          Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      division:        d.fetch("division"),
      fax:             d.fetch("fax"),
      fire_ban_r:      d.fetch("fire_ban_r"),
      latitude:        d.fetch("latitude"),
      local_govt:      d.fetch("local_govt"),
      longitude:       d.fetch("longitude"),
      no:              d.fetch("no"),
      phone:           d.fetch("phone"),
      postcode:        d.fetch("postcode"),
      properties_type: d.fetch("type"),
      psa:             d.fetch("psa"),
      region:          d.fetch("region"),
      station:         d.fetch("station"),
      street:          d.fetch("street"),
      suburb:          d.fetch("suburb"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "division"   => division,
      "fax"        => fax,
      "fire_ban_r" => fire_ban_r,
      "latitude"   => latitude,
      "local_govt" => local_govt,
      "longitude"  => longitude,
      "no"         => no,
      "phone"      => phone,
      "postcode"   => postcode,
      "type"       => properties_type,
      "psa"        => psa,
      "region"     => region,
      "station"    => station,
      "street"     => street,
      "suburb"     => suburb,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Feature < Dry::Struct
  attribute :feature_type,  Types::FeatureType
  attribute :geometry,      Geometry
  attribute :geometry_name, Types::GeometryName
  attribute :id,            Types::String
  attribute :properties,    FeatureProperties

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      feature_type:  d.fetch("type"),
      geometry:      Geometry.from_dynamic!(d.fetch("geometry")),
      geometry_name: d.fetch("geometry_name"),
      id:            d.fetch("id"),
      properties:    FeatureProperties.from_dynamic!(d.fetch("properties")),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "type"          => feature_type,
      "geometry"      => geometry.to_dynamic,
      "geometry_name" => geometry_name,
      "id"            => id,
      "properties"    => properties.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel < Dry::Struct
  attribute :crs,            CRS
  attribute :features,       Types.Array(Feature)
  attribute :top_level_type, Types::String
  attribute :total_features, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      crs:            CRS.from_dynamic!(d.fetch("crs")),
      features:       d.fetch("features").map { |x| Feature.from_dynamic!(x) },
      top_level_type: d.fetch("type"),
      total_features: d.fetch("totalFeatures"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "crs"           => crs.to_dynamic,
      "features"      => features.map { |x| x.to_dynamic },
      "type"          => top_level_type,
      "totalFeatures" => total_features,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
