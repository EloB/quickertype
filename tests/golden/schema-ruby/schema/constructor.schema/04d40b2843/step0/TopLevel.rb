# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.top_level_constructor
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry.Types(default: :nominal)

  Hash   = Strict::Hash
  Double = Strict::Float | Strict::Integer
end

class ConstructorClass < Dry::Struct

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

class UnionConstructor < Dry::Struct
  attribute :constructor_class, ConstructorClass.optional
  attribute :double,            Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = ConstructorClass.from_dynamic!(d)
      if schema.key(:constructor_class).type.right.valid? value
        return new(constructor_class: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, constructor_class: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if constructor_class != nil
      constructor_class.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel < Dry::Struct
  attribute :top_level_constructor, Types.Instance(UnionConstructor).optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      top_level_constructor: d.key?("constructor") ? UnionConstructor.from_dynamic!(d["constructor"]) : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "constructor" => top_level_constructor&.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
