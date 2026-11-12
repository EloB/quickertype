# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.uuid_values.first
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry.Types(default: :nominal)

  Integer = Strict::Integer
  Bool    = Strict::Bool
  Hash    = Strict::Hash
  String  = Strict::String
  Double  = Strict::Float | Strict::Integer
end

class TopLevel < Dry::Struct
  attribute :boolean_value, Types::Bool
  attribute :double_value,  Types::Double
  attribute :int_value,     Types::Integer
  attribute :string_value,  Types::String
  attribute :uuid_value,    Types::String.constrained(format: /\A[0-9a-f]{8}-(?:[0-9a-f]{4}-){3}[0-9a-f]{12}\z/i)
  attribute :uuid_values,   Types.Array(Types::String.constrained(format: /\A[0-9a-f]{8}-(?:[0-9a-f]{4}-){3}[0-9a-f]{12}\z/i))

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      boolean_value: d.fetch("booleanValue"),
      double_value:  d.fetch("doubleValue"),
      int_value:     d.fetch("intValue"),
      string_value:  d.fetch("stringValue"),
      uuid_value:    d.fetch("uuidValue"),
      uuid_values:   d.fetch("uuidValues"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "booleanValue" => boolean_value,
      "doubleValue"  => double_value,
      "intValue"     => int_value,
      "stringValue"  => string_value,
      "uuidValue"    => uuid_value,
      "uuidValues"   => uuid_values,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
