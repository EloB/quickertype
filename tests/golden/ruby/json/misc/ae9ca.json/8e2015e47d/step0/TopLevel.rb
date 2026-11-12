# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.features.first.properties.area
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry.Types(default: :nominal)

  Hash                 = Strict::Hash
  String               = Strict::String
  Double               = Strict::Float | Strict::Integer
  FeatureType          = Strict::String.enum("Feature")
  GeometryType         = Strict::String.enum("Point")
  MaintainingAuthority = Strict::String.enum("City of Ballarat")
  ClassEnum            = Strict::String.enum("No Code Allocated", "OS-District", "OS-Neighbourhood", "OS-Regional")
  Ward                 = Strict::String.enum("South", "North", "Central")
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

module MaintainingAuthority
  CityOfBallarat = "City of Ballarat"
end

module ClassEnum
  NoCodeAllocated = "No Code Allocated"
  OSDistrict      = "OS-District"
  OSNeighbourhood = "OS-Neighbourhood"
  OSRegional      = "OS-Regional"
end

module Ward
  South   = "South"
  North   = "North"
  Central = "Central"
end

class Properties < Dry::Struct
  attribute :area,                  Types::String
  attribute :central_asset_id,      Types::String
  attribute :feature_location,      Types::String
  attribute :lat,                   Types::String
  attribute :long,                  Types::String
  attribute :maintaining_authority, Types::MaintainingAuthority
  attribute :number,                Types::String
  attribute :properties_class,      Types::ClassEnum
  attribute :site_name,             Types::String
  attribute :ward,                  Types::Ward

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      area:                  d.fetch("Area"),
      central_asset_id:      d.fetch("Central Asset ID"),
      feature_location:      d.fetch("Feature Location"),
      lat:                   d.fetch("lat"),
      long:                  d.fetch("long"),
      maintaining_authority: d.fetch("Maintaining Authority"),
      number:                d.fetch("Number"),
      properties_class:      d.fetch("Class"),
      site_name:             d.fetch("Site Name"),
      ward:                  d.fetch("Ward"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "Area"                  => area,
      "Central Asset ID"      => central_asset_id,
      "Feature Location"      => feature_location,
      "lat"                   => lat,
      "long"                  => long,
      "Maintaining Authority" => maintaining_authority,
      "Number"                => number,
      "Class"                 => properties_class,
      "Site Name"             => site_name,
      "Ward"                  => ward,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Feature < Dry::Struct
  attribute :feature_type, Types::FeatureType
  attribute :geometry,     Geometry
  attribute :properties,   Properties

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      feature_type: d.fetch("type"),
      geometry:     Geometry.from_dynamic!(d.fetch("geometry")),
      properties:   Properties.from_dynamic!(d.fetch("properties")),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "type"       => feature_type,
      "geometry"   => geometry.to_dynamic,
      "properties" => properties.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel < Dry::Struct
  attribute :features,       Types.Array(Feature)
  attribute :top_level_name, Types::String
  attribute :top_level_type, Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      features:       d.fetch("features").map { |x| Feature.from_dynamic!(x) },
      top_level_name: d.fetch("name"),
      top_level_type: d.fetch("type"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "features" => features.map { |x| x.to_dynamic },
      "name"     => top_level_name,
      "type"     => top_level_type,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
