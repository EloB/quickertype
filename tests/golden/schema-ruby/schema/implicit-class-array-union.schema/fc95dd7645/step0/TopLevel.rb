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

  Integer = Strict::Integer
  Nil     = Strict::Nil
  Bool    = Strict::Bool
  Hash    = Strict::Hash
  String  = Strict::String
  Double  = Strict::Float | Strict::Integer
end

class FooClass < Dry::Struct
  attribute :bar, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      bar: d.fetch("bar"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "bar" => bar,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class FooUnion < Dry::Struct
  attribute :bool,          Types::Bool.optional
  attribute :double,        Types::Double.optional
  attribute :foo_class,     FooClass.optional
  attribute :integer,       Types::Integer.optional
  attribute :integer_array, Types.Array(Types::Integer).optional
  attribute :null,          Types::Nil.optional
  attribute :string,        Types::String.optional

  def self.from_dynamic!(d)
    if schema.key(:bool).type.right.valid? d
      return new(bool: d, integer_array: nil, foo_class: nil, double: nil, integer: nil, null: nil, string: nil)
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, integer_array: nil, bool: nil, foo_class: nil, integer: nil, null: nil, string: nil)
    end
    begin
      value = FooClass.from_dynamic!(d)
      if schema.key(:foo_class).type.right.valid? value
        return new(foo_class: value, integer_array: nil, bool: nil, double: nil, integer: nil, null: nil, string: nil)
      end
    rescue
    end
    if schema.key(:integer).type.right.valid? d
      return new(integer: d, integer_array: nil, bool: nil, foo_class: nil, double: nil, null: nil, string: nil)
    end
    if schema.key(:integer_array).type.right.valid? d
      return new(integer_array: d, bool: nil, foo_class: nil, double: nil, integer: nil, null: nil, string: nil)
    end
    if schema.key(:null).type.right.valid? d
      return new(null: d, integer_array: nil, bool: nil, foo_class: nil, double: nil, integer: nil, string: nil)
    end
    if schema.key(:string).type.right.valid? d
      return new(string: d, integer_array: nil, bool: nil, foo_class: nil, double: nil, integer: nil, null: nil)
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
    elsif foo_class != nil
      foo_class.to_dynamic
    elsif integer != nil
      integer
    elsif integer_array != nil
      integer_array
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
