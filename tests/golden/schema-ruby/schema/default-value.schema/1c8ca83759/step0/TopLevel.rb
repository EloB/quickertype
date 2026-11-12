# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.id.even?
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry.Types(default: :nominal)

  Integer = Strict::Integer
  Hash    = Strict::Hash
end

# An object with a scalar default
class TopLevel < Dry::Struct
  attribute :id, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      id: d.fetch("id"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "id" => id,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
