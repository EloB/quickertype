# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.value
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry.Types(default: :nominal)

  Hash   = Strict::Hash
  Double = Strict::Float | Strict::Integer
end

class TopLevel < Dry::Struct
  attribute :value, Types::Double.constrained(gteq: 0.1, lteq: 0.9)

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      value: d.fetch("value"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "value" => value,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
