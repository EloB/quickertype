# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.text_node
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry.Types(default: :nominal)

  Integer = Strict::Integer
  Nil     = Strict::Nil
  Bool    = Strict::Bool
  Hash    = Strict::Hash
  String  = Strict::String
  Double  = Strict::Float | Strict::Integer
end

class ArrayNode < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class BooleanNode < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class DoubleNode < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class IntNode < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class LongNode < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class NullNode < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class ObjectNode < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Anything < Dry::Struct
  attribute :anything_array, Types.Array(Types::Any).optional
  attribute :anything_map,   Types::Hash.meta(of: Types::Any).optional
  attribute :bool,           Types::Bool.optional
  attribute :double,         Types::Double.optional
  attribute :integer,        Types::Integer.optional
  attribute :null,           Types::Nil.optional
  attribute :string,         Types::String.optional

  def self.from_dynamic!(d)
    if schema.key(:anything_array).type.right.valid? d
      return new(anything_array: d, bool: nil, double: nil, integer: nil, anything_map: nil, null: nil, string: nil)
    end
    begin
      value = Types::Hash[d].map { |k, v| [k, Types::Any[v]] }.to_h
      if schema.key(:anything_map).type.right.valid? value
        return new(anything_map: value, anything_array: nil, bool: nil, double: nil, integer: nil, null: nil, string: nil)
      end
    rescue
    end
    if schema.key(:bool).type.right.valid? d
      return new(bool: d, anything_array: nil, double: nil, integer: nil, anything_map: nil, null: nil, string: nil)
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, anything_array: nil, bool: nil, integer: nil, anything_map: nil, null: nil, string: nil)
    end
    if schema.key(:integer).type.right.valid? d
      return new(integer: d, anything_array: nil, bool: nil, double: nil, anything_map: nil, null: nil, string: nil)
    end
    if schema.key(:null).type.right.valid? d
      return new(null: d, anything_array: nil, bool: nil, double: nil, integer: nil, anything_map: nil, string: nil)
    end
    if schema.key(:string).type.right.valid? d
      return new(string: d, anything_array: nil, bool: nil, double: nil, integer: nil, anything_map: nil, null: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if anything_array != nil
      anything_array
    elsif anything_map != nil
      anything_map
    elsif bool != nil
      bool
    elsif double != nil
      double
    elsif integer != nil
      integer
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

class Thing < Dry::Struct
  attribute :thing_optional, Types.Instance(Anything).optional
  attribute :required,       Types.Instance(Anything)

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      thing_optional: d["optional"] ? Anything.from_dynamic!(d["optional"]) : nil,
      required:       Anything.from_dynamic!(d.fetch("required")),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "optional" => thing_optional&.to_dynamic,
      "required" => required.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TextNode < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel < Dry::Struct
  attribute :array_node,   ArrayNode.optional
  attribute :boolean_node, BooleanNode.optional
  attribute :double_node,  DoubleNode.optional
  attribute :int_node,     IntNode.optional
  attribute :long_node,    LongNode.optional
  attribute :null_node,    NullNode.optional
  attribute :object_node,  ObjectNode.optional
  attribute :stuff,        Types::Hash.meta(of: Thing)
  attribute :text_node,    TextNode.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      array_node:   d.key?("arrayNode") ? ArrayNode.from_dynamic!(d["arrayNode"]) : nil,
      boolean_node: d.key?("booleanNode") ? BooleanNode.from_dynamic!(d["booleanNode"]) : nil,
      double_node:  d.key?("doubleNode") ? DoubleNode.from_dynamic!(d["doubleNode"]) : nil,
      int_node:     d.key?("intNode") ? IntNode.from_dynamic!(d["intNode"]) : nil,
      long_node:    d.key?("longNode") ? LongNode.from_dynamic!(d["longNode"]) : nil,
      null_node:    d.key?("nullNode") ? NullNode.from_dynamic!(d["nullNode"]) : nil,
      object_node:  d.key?("objectNode") ? ObjectNode.from_dynamic!(d["objectNode"]) : nil,
      stuff:        Types::Hash[d.fetch("stuff")].map { |k, v| [k, Thing.from_dynamic!(v)] }.to_h,
      text_node:    d.key?("textNode") ? TextNode.from_dynamic!(d["textNode"]) : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "arrayNode"   => array_node&.to_dynamic,
      "booleanNode" => boolean_node&.to_dynamic,
      "doubleNode"  => double_node&.to_dynamic,
      "intNode"     => int_node&.to_dynamic,
      "longNode"    => long_node&.to_dynamic,
      "nullNode"    => null_node&.to_dynamic,
      "objectNode"  => object_node&.to_dynamic,
      "stuff"       => stuff.map { |k, v| [k, v.to_dynamic] }.to_h,
      "textNode"    => text_node&.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
