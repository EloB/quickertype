# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.features.first.properties.facebookaccount
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry.Types(default: :nominal)

  Integer      = Strict::Integer
  Hash         = Strict::Hash
  String       = Strict::String
  Double       = Strict::Float | Strict::Integer
  FeatureType  = Strict::String.enum("Feature")
  GeometryType = Strict::String.enum("MultiPoint")
  GeometryName = Strict::String.enum("geom")
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
  MultiPoint = "MultiPoint"
end

class Geometry < Dry::Struct
  attribute :coordinates,   Types.Array(Types.Array(Types::Double))
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

class FeatureProperties < Dry::Struct
  attribute :facebookaccount,    Types::String
  attribute :frequencyfinderurl, Types::String
  attribute :properties_name,    Types::String
  attribute :siteurl,            Types::String
  attribute :streetaddress,      Types::String
  attribute :twitteraccount,     Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      facebookaccount:    d.fetch("facebookaccount"),
      frequencyfinderurl: d.fetch("frequencyfinderurl"),
      properties_name:    d.fetch("name"),
      siteurl:            d.fetch("siteurl"),
      streetaddress:      d.fetch("streetaddress"),
      twitteraccount:     d.fetch("twitteraccount"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "facebookaccount"    => facebookaccount,
      "frequencyfinderurl" => frequencyfinderurl,
      "name"               => properties_name,
      "siteurl"            => siteurl,
      "streetaddress"      => streetaddress,
      "twitteraccount"     => twitteraccount,
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
