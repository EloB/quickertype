# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.pairs["…"].decimal_places.even?
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry.Types(default: :nominal)

  Integer = Strict::Integer
  Hash    = Strict::Hash
  Double  = Strict::Float | Strict::Integer
end

class Pair < Dry::Struct
  attribute :decimal_places, Types::Integer
  attribute :fee,            Types::Double
  attribute :hidden,         Types::Integer
  attribute :max_amount,     Types::Integer
  attribute :max_price,      Types::Integer
  attribute :min_amount,     Types::Double
  attribute :min_price,      Types::Double
  attribute :min_total,      Types::Double

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      decimal_places: d.fetch("decimal_places"),
      fee:            d.fetch("fee"),
      hidden:         d.fetch("hidden"),
      max_amount:     d.fetch("max_amount"),
      max_price:      d.fetch("max_price"),
      min_amount:     d.fetch("min_amount"),
      min_price:      d.fetch("min_price"),
      min_total:      d.fetch("min_total"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "decimal_places" => decimal_places,
      "fee"            => fee,
      "hidden"         => hidden,
      "max_amount"     => max_amount,
      "max_price"      => max_price,
      "min_amount"     => min_amount,
      "min_price"      => min_price,
      "min_total"      => min_total,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel < Dry::Struct
  attribute :pairs,       Types::Hash.meta(of: Pair)
  attribute :server_time, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      pairs:       Types::Hash[d.fetch("pairs")].map { |k, v| [k, Pair.from_dynamic!(v)] }.to_h,
      server_time: d.fetch("server_time"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "pairs"       => pairs.map { |k, v| [k, v.to_dynamic] }.to_h,
      "server_time" => server_time,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
