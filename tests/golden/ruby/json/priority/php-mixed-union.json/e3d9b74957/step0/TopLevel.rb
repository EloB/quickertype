# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.mixed.first
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

class MixedClass < Dry::Struct
  attribute :nested, Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      nested: d.fetch("nested"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "nested" => nested,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class MixedElement < Dry::Struct
  attribute :bool,        Types::Bool.optional
  attribute :integer,     Types::Integer.optional
  attribute :mixed_class, MixedClass.optional
  attribute :null,        Types::Nil.optional
  attribute :string,      Types::String.optional

  def self.from_dynamic!(d)
    if schema.key(:bool).type.right.valid? d
      return new(bool: d, mixed_class: nil, integer: nil, null: nil, string: nil)
    end
    if schema.key(:integer).type.right.valid? d
      return new(integer: d, bool: nil, mixed_class: nil, null: nil, string: nil)
    end
    begin
      value = MixedClass.from_dynamic!(d)
      if schema.key(:mixed_class).type.right.valid? value
        return new(mixed_class: value, bool: nil, integer: nil, null: nil, string: nil)
      end
    rescue
    end
    if schema.key(:null).type.right.valid? d
      return new(null: d, bool: nil, mixed_class: nil, integer: nil, string: nil)
    end
    if schema.key(:string).type.right.valid? d
      return new(string: d, bool: nil, mixed_class: nil, integer: nil, null: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if bool != nil
      bool
    elsif integer != nil
      integer
    elsif mixed_class != nil
      mixed_class.to_dynamic
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
  attribute :mixed, Types.Array(Types.Instance(MixedElement))

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      mixed: d.fetch("mixed").map { |x| MixedElement.from_dynamic!(x) },
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "mixed" => mixed.map { |x| x.to_dynamic },
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
