# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.copy_with.even?
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
end

class TopLevel < Dry::Struct
  attribute :copy_with,      Types::Integer
  attribute :top_level_name, Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      copy_with:      d.fetch("copyWith"),
      top_level_name: d.fetch("name"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "copyWith" => copy_with,
      "name"     => top_level_name,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
