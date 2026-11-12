# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.my_property
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
  attribute :my_property,     Types::String.optional
  attribute :second_property, Types::String.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      my_property:     d.key?("myProperty") ? Types::String[d["myProperty"]] : nil,
      second_property: d.key?("secondProperty") ? Types::String[d["secondProperty"]] : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "myProperty"     => my_property,
      "secondProperty" => second_property,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
