# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.top_level_enum.nil?
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry.Types(default: :nominal)

  Nil    = Strict::Nil
  Hash   = Strict::Hash
  String = Strict::String
  Enum   = Strict::String.enum("foo", "bar")
end

module Enum
  Foo = "foo"
  Bar = "bar"
end

class TopLevel < Dry::Struct
  attribute :top_level_enum, Types::Enum.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      top_level_enum: d.fetch("enum"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "enum" => top_level_enum,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
