# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.required_coordinates.first.latitude
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry.Types(default: :nominal)

  Integer = Strict::Integer
  Hash    = Strict::Hash
  String  = Strict::String
  Double  = Strict::Float | Strict::Integer
end

class Coordinate < Dry::Struct
  attribute :latitude,  Types::Double
  attribute :longitude, Types::Double

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      latitude:  d.fetch("latitude"),
      longitude: d.fetch("longitude"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "latitude"  => latitude,
      "longitude" => longitude,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel < Dry::Struct
  attribute :coordinates,          Types.Array(Coordinate).optional
  attribute :count,                Types::Integer.constrained(gteq: 1, lteq: 100).optional
  attribute :label,                Types::String.constrained(min_size: 2, max_size: 16).optional
  attribute :required_coordinates, Types.Array(Coordinate)
  attribute :required_count,       Types::Integer.constrained(gteq: 1, lteq: 100)
  attribute :required_label,       Types::String.constrained(min_size: 2, max_size: 16)
  attribute :weight,               Types::Double.constrained(gteq: 0.5, lteq: 99.5).optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      coordinates:          d.key?("coordinates") ? d["coordinates"].map { |x| Coordinate.from_dynamic!(x) } : nil,
      count:                d.key?("count") ? Types::Integer.constrained(gteq: 1, lteq: 100)[d["count"]] : nil,
      label:                d.key?("label") ? Types::String.constrained(min_size: 2, max_size: 16)[d["label"]] : nil,
      required_coordinates: d.fetch("requiredCoordinates").map { |x| Coordinate.from_dynamic!(x) },
      required_count:       d.fetch("requiredCount"),
      required_label:       d.fetch("requiredLabel"),
      weight:               d.key?("weight") ? Types::Double.constrained(gteq: 0.5, lteq: 99.5)[d["weight"]] : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "coordinates"         => coordinates&.map { |x| x.to_dynamic },
      "count"               => count,
      "label"               => label,
      "requiredCoordinates" => required_coordinates.map { |x| x.to_dynamic },
      "requiredCount"       => required_count,
      "requiredLabel"       => required_label,
      "weight"              => weight,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
