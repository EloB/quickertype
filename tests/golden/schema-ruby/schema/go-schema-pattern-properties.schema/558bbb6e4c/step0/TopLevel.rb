# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.map["…"].even?
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry.Types(default: :nominal)

  Integer = Strict::Integer
  Hash    = Strict::Hash
end

class TopLevel < Dry::Struct
  attribute :map, Types::Hash.meta(of: Types::Integer)

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      map: Types::Hash[d.fetch("map")].map { |k, v| [k, Types::Integer[v]] }.to_h,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "map" => map,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
