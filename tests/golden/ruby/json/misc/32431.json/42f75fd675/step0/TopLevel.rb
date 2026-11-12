# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.metadata.api
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
  MagType        = Strict::String.enum("md", "ml", "mb")
  PropertiesType = Strict::String.enum("earthquake")
  Status         = Strict::String.enum("automatic", "reviewed")
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

module MagType
  Md = "md"
  Ml = "ml"
  MB = "mb"
end

module PropertiesType
  Earthquake = "earthquake"
end

module Status
  Automatic = "automatic"
  Reviewed  = "reviewed"
end

class Properties < Dry::Struct
  attribute :alert,           Types::Nil
  attribute :cdi,             Types::Nil
  attribute :code,            Types::String
  attribute :detail,          Types::String
  attribute :dmin,            Types::Double.optional
  attribute :felt,            Types::Nil
  attribute :gap,             Types::Integer.optional
  attribute :ids,             Types::String
  attribute :mag,             Types::Double
  attribute :mag_type,        Types::MagType
  attribute :mmi,             Types::Nil
  attribute :net,             Types::String
  attribute :nst,             Types::Integer.optional
  attribute :place,           Types::String
  attribute :properties_type, Types::PropertiesType
  attribute :rms,             Types::Double
  attribute :sig,             Types::Integer
  attribute :sources,         Types::String
  attribute :status,          Types::Status
  attribute :time,            Types::Integer
  attribute :title,           Types::String
  attribute :tsunami,         Types::Integer
  attribute :types,           Types::String
  attribute :tz,              Types::Integer
  attribute :updated,         Types::Integer
  attribute :url,             Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      alert:           d.fetch("alert"),
      cdi:             d.fetch("cdi"),
      code:            d.fetch("code"),
      detail:          d.fetch("detail"),
      dmin:            d.fetch("dmin"),
      felt:            d.fetch("felt"),
      gap:             d.fetch("gap"),
      ids:             d.fetch("ids"),
      mag:             d.fetch("mag"),
      mag_type:        d.fetch("magType"),
      mmi:             d.fetch("mmi"),
      net:             d.fetch("net"),
      nst:             d.fetch("nst"),
      place:           d.fetch("place"),
      properties_type: d.fetch("type"),
      rms:             d.fetch("rms"),
      sig:             d.fetch("sig"),
      sources:         d.fetch("sources"),
      status:          d.fetch("status"),
      time:            d.fetch("time"),
      title:           d.fetch("title"),
      tsunami:         d.fetch("tsunami"),
      types:           d.fetch("types"),
      tz:              d.fetch("tz"),
      updated:         d.fetch("updated"),
      url:             d.fetch("url"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "alert"   => alert,
      "cdi"     => cdi,
      "code"    => code,
      "detail"  => detail,
      "dmin"    => dmin,
      "felt"    => felt,
      "gap"     => gap,
      "ids"     => ids,
      "mag"     => mag,
      "magType" => mag_type,
      "mmi"     => mmi,
      "net"     => net,
      "nst"     => nst,
      "place"   => place,
      "type"    => properties_type,
      "rms"     => rms,
      "sig"     => sig,
      "sources" => sources,
      "status"  => status,
      "time"    => time,
      "title"   => title,
      "tsunami" => tsunami,
      "types"   => types,
      "tz"      => tz,
      "updated" => updated,
      "url"     => url,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Feature < Dry::Struct
  attribute :feature_type, Types::FeatureType
  attribute :geometry,     Geometry
  attribute :id,           Types::String
  attribute :properties,   Properties

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      feature_type: d.fetch("type"),
      geometry:     Geometry.from_dynamic!(d.fetch("geometry")),
      id:           d.fetch("id"),
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
      "id"         => id,
      "properties" => properties.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Metadata < Dry::Struct
  attribute :api,       Types::String
  attribute :count,     Types::Integer
  attribute :generated, Types::Integer
  attribute :status,    Types::Integer
  attribute :title,     Types::String
  attribute :url,       Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      api:       d.fetch("api"),
      count:     d.fetch("count"),
      generated: d.fetch("generated"),
      status:    d.fetch("status"),
      title:     d.fetch("title"),
      url:       d.fetch("url"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "api"       => api,
      "count"     => count,
      "generated" => generated,
      "status"    => status,
      "title"     => title,
      "url"       => url,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel < Dry::Struct
  attribute :bbox,           Types.Array(Types::Double)
  attribute :features,       Types.Array(Feature)
  attribute :metadata,       Metadata
  attribute :top_level_type, Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      bbox:           d.fetch("bbox"),
      features:       d.fetch("features").map { |x| Feature.from_dynamic!(x) },
      metadata:       Metadata.from_dynamic!(d.fetch("metadata")),
      top_level_type: d.fetch("type"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "bbox"     => bbox,
      "features" => features.map { |x| x.to_dynamic },
      "metadata" => metadata.to_dynamic,
      "type"     => top_level_type,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
