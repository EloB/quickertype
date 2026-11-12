# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "[…]"
#   puts top_level.first.geolocation&.coordinates.first
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry.Types(default: :nominal)

  Hash     = Strict::Hash
  String   = Strict::String
  Double   = Strict::Float | Strict::Integer
  Fall     = Strict::String.enum("Fell", "Found")
  Type     = Strict::String.enum("Point")
  Nametype = Strict::String.enum("Valid")
end

module Fall
  Fell  = "Fell"
  Found = "Found"
end

module Type
  Point = "Point"
end

class Geolocation < Dry::Struct
  attribute :coordinates,      Types.Array(Types::Double)
  attribute :geolocation_type, Types::Type

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      coordinates:      d.fetch("coordinates"),
      geolocation_type: d.fetch("type"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "coordinates" => coordinates,
      "type"        => geolocation_type,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

module Nametype
  Valid = "Valid"
end

class TopLevelElement < Dry::Struct
  attribute :computed_region_cbhk_fwbd,  Types::String.optional
  attribute :computed_region_nnqa_25_f4, Types::String.optional
  attribute :fall,                       Types::Fall
  attribute :geolocation,                Geolocation.optional
  attribute :id,                         Types::String
  attribute :mass,                       Types::String.optional
  attribute :nametype,                   Types::Nametype
  attribute :recclass,                   Types::String
  attribute :reclat,                     Types::String.optional
  attribute :reclong,                    Types::String.optional
  attribute :top_level_name,             Types::String
  attribute :year,                       Types::String.constrained(format: /\A\d{4}-\d\d-\d\dT\d\d:\d\d:\d\d(?:\.\d+)?(?:Z|[+-]\d\d:\d\d)\z/i).optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      computed_region_cbhk_fwbd:  d.key?(":@computed_region_cbhk_fwbd") ? Types::String[d[":@computed_region_cbhk_fwbd"]] : nil,
      computed_region_nnqa_25_f4: d.key?(":@computed_region_nnqa_25f4") ? Types::String[d[":@computed_region_nnqa_25f4"]] : nil,
      fall:                       d.fetch("fall"),
      geolocation:                d.key?("geolocation") ? Geolocation.from_dynamic!(d["geolocation"]) : nil,
      id:                         d.fetch("id"),
      mass:                       d.key?("mass") ? Types::String[d["mass"]] : nil,
      nametype:                   d.fetch("nametype"),
      recclass:                   d.fetch("recclass"),
      reclat:                     d.key?("reclat") ? Types::String[d["reclat"]] : nil,
      reclong:                    d.key?("reclong") ? Types::String[d["reclong"]] : nil,
      top_level_name:             d.fetch("name"),
      year:                       d.key?("year") ? Types::String.constrained(format: /\A\d{4}-\d\d-\d\dT\d\d:\d\d:\d\d(?:\.\d+)?(?:Z|[+-]\d\d:\d\d)\z/i)[d["year"]] : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      ":@computed_region_cbhk_fwbd" => computed_region_cbhk_fwbd,
      ":@computed_region_nnqa_25f4" => computed_region_nnqa_25_f4,
      "fall"                        => fall,
      "geolocation"                 => geolocation&.to_dynamic,
      "id"                          => id,
      "mass"                        => mass,
      "nametype"                    => nametype,
      "recclass"                    => recclass,
      "reclat"                      => reclat,
      "reclong"                     => reclong,
      "name"                        => top_level_name,
      "year"                        => year,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel
  def self.from_json!(json)
    top_level = JSON.parse(json, quirks_mode: true).map { |x| TopLevelElement.from_dynamic!(x) }
    top_level.define_singleton_method(:to_json) do
      JSON.generate(self.map { |x| x.to_dynamic })
    end
    top_level
  end
end
