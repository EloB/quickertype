# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.data.even?
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry.Types(default: :nominal)

  Integer = Strict::Integer
  Nil     = Strict::Nil
  Hash    = Strict::Hash
end

class TopLevel < Dry::Struct
  attribute :data,           Types::Integer
  attribute :top_level_next, TopLevel.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      data:           d.fetch("data"),
      top_level_next: d.fetch("next") ? TopLevel.from_dynamic!(d.fetch("next")) : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "data" => data,
      "next" => top_level_next&.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
