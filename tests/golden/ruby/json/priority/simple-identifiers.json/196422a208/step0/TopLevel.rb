# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.continue
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
  attribute :continue,    Types::String
  attribute :empty,       Types::String
  attribute :null,        Types::String
  attribute :top_level,   Types::String
  attribute :top_level_x, Types::String
  attribute :undefined,   Types::String
  attribute :x,           Types::String
  attribute :x_1,         Types::String
  attribute :x_y,         Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      continue:    d.fetch("continue"),
      empty:       d.fetch(""),
      null:        d.fetch("null"),
      top_level:   d.fetch("{}"),
      top_level_x: d.fetch("x\""),
      undefined:   d.fetch("undefined"),
      x:           d.fetch("x"),
      x_1:         d.fetch("x'"),
      x_y:         d.fetch("x y"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "continue"  => continue,
      ""          => empty,
      "null"      => null,
      "{}"        => top_level,
      "x\""       => top_level_x,
      "undefined" => undefined,
      "x"         => x,
      "x'"        => x_1,
      "x y"       => x_y,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
