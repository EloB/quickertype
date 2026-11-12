# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.top_level_next
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
end

# (forward declaration)
class Node < Dry::Struct; end

class Next < Dry::Struct
  attribute :node,   Node.optional
  attribute :null,   Types::Nil.optional
  attribute :string, Types::String.optional

  def self.from_dynamic!(d)
    begin
      value = Node.from_dynamic!(d)
      if schema.key(:node).type.right.valid? value
        return new(node: value, null: nil, string: nil)
      end
    rescue
    end
    if schema.key(:null).type.right.valid? d
      return new(null: d, node: nil, string: nil)
    end
    if schema.key(:string).type.right.valid? d
      return new(string: d, node: nil, null: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if node != nil
      node.to_dynamic
    elsif string != nil
      string
    else
      nil
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Node < Dry::Struct
  attribute :node_next, Types.Instance(Next).optional
  attribute :value,     Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      node_next: d["next"] ? Next.from_dynamic!(d["next"]) : nil,
      value:     d.fetch("value"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "next"  => node_next&.to_dynamic,
      "value" => value,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel < Dry::Struct
  attribute :top_level_next, Types.Instance(Next).optional
  attribute :value,          Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      top_level_next: d["next"] ? Next.from_dynamic!(d["next"]) : nil,
      value:          d.fetch("value"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "next"  => top_level_next&.to_dynamic,
      "value" => value,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
