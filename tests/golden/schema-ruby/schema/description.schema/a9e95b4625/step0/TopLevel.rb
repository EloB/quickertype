# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.bar
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry.Types(default: :nominal)

  Bool   = Strict::Bool
  Hash   = Strict::Hash
  String = Strict::String
  Double = Strict::Float | Strict::Integer
  Enum   = Strict::String.enum("foo", "bar")
end

class ObjectOrStringClass < Dry::Struct

  # This must not get lost
  attribute :prop, Types::Double

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      prop: d.fetch("prop"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "prop" => prop,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class ObjectOrStringUnion < Dry::Struct
  attribute :object_or_string_class, ObjectOrStringClass.optional
  attribute :string,                 Types::String.optional

  def self.from_dynamic!(d)
    begin
      value = ObjectOrStringClass.from_dynamic!(d)
      if schema.key(:object_or_string_class).type.right.valid? value
        return new(object_or_string_class: value, string: nil)
      end
    rescue
    end
    if schema.key(:string).type.right.valid? d
      return new(string: d, object_or_string_class: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if object_or_string_class != nil
      object_or_string_class.to_dynamic
    elsif string != nil
      string
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

# An enumeration
module Enum
  Foo = "foo"
  Bar = "bar"
end

# Either a number or a string
class Union < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :string, Types::String.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, string: nil)
    end
    if schema.key(:string).type.right.valid? d
      return new(string: d, double: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif string != nil
      string
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

# The top-level class.
# Its description has two lines.
class TopLevel < Dry::Struct

  # A pretty boolean
  attribute :bar, Types::Bool.optional

  # An enumeration
  attribute :top_level_enum, Types::Enum

  attribute :foo,              Types::Double.optional
  attribute :object_or_string, Types.Instance(ObjectOrStringUnion)

  # Either a number or a string
  attribute :union, Types.Instance(Union)

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      bar:              d.key?("bar") ? Types::Bool[d["bar"]] : nil,
      top_level_enum:   d.fetch("enum"),
      foo:              d.key?("foo") ? Types::Double[d["foo"]] : nil,
      object_or_string: ObjectOrStringUnion.from_dynamic!(d.fetch("object-or-string")),
      union:            Union.from_dynamic!(d.fetch("union")),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "bar"              => bar,
      "enum"             => top_level_enum,
      "foo"              => foo,
      "object-or-string" => object_or_string.to_dynamic,
      "union"            => union.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
