# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.values.first == Value::C0
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
  Value   = Strict::String.enum("c0\u{1}\u{1b}\u{1f}", "c1\u{7f}\u{80}\u{85}\u{9f}")
end

module Value
  C0 = "c0\u{1}\u{1b}\u{1f}"
  C1 = "c1\u{7f}\u{80}\u{85}\u{9f}"
end

class TopLevel < Dry::Struct
  attribute :literal, Types::String
  attribute :the_11,  Types::Integer
  attribute :values,  Types.Array(Types::Value)

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      literal: d.fetch("literal"),
      the_11:  d.fetch("\u{23}{1+1}"),
      values:  d.fetch("values"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "literal"     => literal,
      "\u{23}{1+1}" => the_11,
      "values"      => values,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
