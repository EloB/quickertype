# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.exact
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry.Types(default: :nominal)

  Hash   = Strict::Hash
  String = Strict::String
end

class TopLevel < Dry::Struct
  attribute :exact,   Types::String.constrained(min_size: 2, max_size: 2).constrained(format: Regexp.new("^[^!]+$"))
  attribute :maximum, Types::String.constrained(max_size: 1)
  attribute :minimum, Types::String.constrained(min_size: 2)

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      exact:   d.fetch("exact"),
      maximum: d.fetch("maximum"),
      minimum: d.fetch("minimum"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "exact"   => exact,
      "maximum" => maximum,
      "minimum" => minimum,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
