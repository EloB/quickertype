# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.children_data.first.children_data.first.children_data.first
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry.Types(default: :nominal)

  Integer = Strict::Integer
  Bool    = Strict::Bool
  Hash    = Strict::Hash
  String  = Strict::String
end

class TopLevel < Dry::Struct
  attribute :children_data,  Types.Array(TopLevel)
  attribute :id,             Types::Integer
  attribute :is_active,      Types::Bool
  attribute :level,          Types::Integer
  attribute :parent_id,      Types::Integer
  attribute :position,       Types::Integer
  attribute :product_count,  Types::Integer
  attribute :top_level_name, Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      children_data:  d.fetch("children_data").map { |x| TopLevel.from_dynamic!(x) },
      id:             d.fetch("id"),
      is_active:      d.fetch("is_active"),
      level:          d.fetch("level"),
      parent_id:      d.fetch("parent_id"),
      position:       d.fetch("position"),
      product_count:  d.fetch("product_count"),
      top_level_name: d.fetch("name"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "children_data" => children_data.map { |x| x.to_dynamic },
      "id"            => id,
      "is_active"     => is_active,
      "level"         => level,
      "parent_id"     => parent_id,
      "position"      => position,
      "product_count" => product_count,
      "name"          => top_level_name,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
