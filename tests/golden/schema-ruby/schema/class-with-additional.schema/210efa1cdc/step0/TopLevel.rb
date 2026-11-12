# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.map&["…"]
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry.Types(default: :nominal)

  Bool   = Strict::Bool
  Hash   = Strict::Hash
  Double = Strict::Float | Strict::Integer
end

class Map < Dry::Struct
  attribute :bool,   Types::Bool.optional
  attribute :double, Types::Double.optional

  def self.from_dynamic!(d)
    if schema.key(:bool).type.right.valid? d
      return new(bool: d, double: nil)
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, bool: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if bool != nil
      bool
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel < Dry::Struct
  attribute :map, Types::Hash.meta(of: Types.Instance(Map)).optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      map: d.key?("map") ? Types::Hash[d["map"]].map { |k, v| [k, Map.from_dynamic!(v)] }.to_h : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "map" => map&.map { |k, v| [k, v.to_dynamic] }.to_h,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
