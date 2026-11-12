# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.foo
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry.Types(default: :nominal)

  Bool = Strict::Bool
  Hash = Strict::Hash
end

# Cool "stuff"
class TopLevel < Dry::Struct
  attribute :foo, Types::Bool.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      foo: d.key?("foo") ? Types::Bool[d["foo"]] : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "foo" => foo,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
