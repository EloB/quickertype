# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.z.first
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
end

class X < Dry::Struct
  attribute :integer, Types::Integer.optional
  attribute :null,    Types::Nil.optional
  attribute :string,  Types::String.optional

  def self.from_dynamic!(d)
    if schema.key(:integer).type.right.valid? d
      return new(integer: d, null: nil, string: nil)
    end
    if schema.key(:null).type.right.valid? d
      return new(null: d, integer: nil, string: nil)
    end
    if schema.key(:string).type.right.valid? d
      return new(string: d, integer: nil, null: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if integer != nil
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

class ZClass < Dry::Struct
  attribute :a, Types::Bool

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      a: d.fetch("a"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "a" => a,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class ZElement < Dry::Struct
  attribute :integer,       Types::Integer.optional
  attribute :integer_array, Types.Array(Types::Integer).optional
  attribute :z_class,       ZClass.optional

  def self.from_dynamic!(d)
    if schema.key(:integer).type.right.valid? d
      return new(integer: d, integer_array: nil, z_class: nil)
    end
    if schema.key(:integer_array).type.right.valid? d
      return new(integer_array: d, z_class: nil, integer: nil)
    end
    begin
      value = ZClass.from_dynamic!(d)
      if schema.key(:z_class).type.right.valid? value
        return new(z_class: value, integer_array: nil, integer: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if integer != nil
      integer
    elsif integer_array != nil
      integer_array
    elsif z_class != nil
      z_class.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel < Dry::Struct
  attribute :x, Types.Array(Types.Instance(X))
  attribute :y, Types.Array(Types::Integer.optional)
  attribute :z, Types.Array(Types.Instance(ZElement))

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      x: d.fetch("x").map { |x| X.from_dynamic!(x) },
      y: d.fetch("y"),
      z: d.fetch("z").map { |x| ZElement.from_dynamic!(x) },
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "x" => x.map { |x| x.to_dynamic },
      "y" => y,
      "z" => z.map { |x| x.to_dynamic },
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
