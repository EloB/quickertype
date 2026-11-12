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

  Bool    = Strict::Bool
  Hash    = Strict::Hash
  String  = Strict::String
  Double  = Strict::Float | Strict::Integer
  FooEnum = Strict::String.enum("a", "b", "c")
end

module FooEnum
  A = "a"
  B = "b"
  C = "c"
end

class FooUnion < Dry::Struct
  attribute :bool,   Types::Bool.optional
  attribute :double, Types::Double.optional
  attribute :enum_1, Types::FooEnum.optional

  def self.from_dynamic!(d)
    if schema.key(:bool).type.right.valid? d
      return new(bool: d, double: nil, enum_1: nil)
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, bool: nil, enum_1: nil)
    end
    if schema.key(:enum_1).type.right.valid? d
      return new(enum_1: d, bool: nil, double: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if bool != nil
      bool
    elsif double != nil
      double
    elsif enum_1 != nil
      enum_1
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel < Dry::Struct
  attribute :foo, Types.Instance(FooUnion)

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      foo: FooUnion.from_dynamic!(d.fetch("foo")),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "foo" => foo.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
