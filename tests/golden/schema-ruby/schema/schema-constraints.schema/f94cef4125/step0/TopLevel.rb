# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.min_max_length
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry.Types(default: :nominal)

  Hash   = Strict::Hash
  String = Strict::String
  Double = Strict::Float | Strict::Integer
end

class TopLevel < Dry::Struct
  attribute :min_max_length, Types::String.constrained(min_size: 5, max_size: 5)
  attribute :percent,        Types::Double.constrained(gteq: 0, lteq: 1)

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      min_max_length: d.fetch("minMaxLength"),
      percent:        d.fetch("percent"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "minMaxLength" => min_max_length,
      "percent"      => percent,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
