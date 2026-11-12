# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.barre
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
  Enum   = Strict::String.enum("red", "green", "blue")
end

module Enum
  Fire  = "red"
  Grass = "green"
  Blue  = "blue"
end

class Union < Dry::Struct
  attribute :amount,   Types::Double.optional
  attribute :presence, Types::Bool.optional

  def self.from_dynamic!(d)
    if schema.key(:amount).type.right.valid? d
      return new(amount: d, presence: nil)
    end
    if schema.key(:presence).type.right.valid? d
      return new(presence: d, amount: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if amount != nil
      amount
    elsif presence != nil
      presence
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel < Dry::Struct
  attribute :barre,           Types::String
  attribute :enumerification, Types::Enum
  attribute :foo,             Types::String
  attribute :unionization,    Types.Instance(Union)

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      barre:           d.fetch("bar"),
      enumerification: d.fetch("enum"),
      foo:             d.fetch("foo"),
      unionization:    Union.from_dynamic!(d.fetch("union")),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "bar"   => barre,
      "enum"  => enumerification,
      "foo"   => foo,
      "union" => unionization.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
