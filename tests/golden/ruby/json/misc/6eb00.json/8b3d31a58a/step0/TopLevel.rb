# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "[…]"
#   puts top_level.first.directorate_id.even?
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

class TopLevelElement < Dry::Struct
  attribute :directorate_id, Types::Integer
  attribute :id,             Types::Integer
  attribute :top_level_name, Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      directorate_id: d.fetch("DirectorateID"),
      id:             d.fetch("Id"),
      top_level_name: d.fetch("Name"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "DirectorateID" => directorate_id,
      "Id"            => id,
      "Name"          => top_level_name,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel
  def self.from_json!(json)
    top_level = JSON.parse(json, quirks_mode: true).map { |x| TopLevelElement.from_dynamic!(x) }
    top_level.define_singleton_method(:to_json) do
      JSON.generate(self.map { |x| x.to_dynamic })
    end
    top_level
  end
end
