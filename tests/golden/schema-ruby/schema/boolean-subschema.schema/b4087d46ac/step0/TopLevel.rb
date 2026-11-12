# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.empty.first
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
  attribute :disallowed, Types::Any.optional
  attribute :empty,      Types.Array(Types::Any)
  attribute :foo,        Types::String
  attribute :impossible, Types::Any.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      disallowed: d["disallowed"],
      empty:      d.fetch("empty"),
      foo:        d.fetch("foo"),
      impossible: d["impossible"],
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "disallowed" => disallowed,
      "empty"      => empty,
      "foo"        => foo,
      "impossible" => impossible,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
