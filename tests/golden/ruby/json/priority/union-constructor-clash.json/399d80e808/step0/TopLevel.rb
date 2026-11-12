# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.union.first
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
end

class BoolInUnion < Dry::Struct
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

class Union < Dry::Struct
  attribute :bool,    Types::Bool.optional
  attribute :integer, Types::Integer.optional

  def self.from_dynamic!(d)
    if schema.key(:bool).type.right.valid? d
      return new(bool: d, integer: nil)
    end
    if schema.key(:integer).type.right.valid? d
      return new(integer: d, bool: nil)
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
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel < Dry::Struct
  attribute :bool_in_union, BoolInUnion
  attribute :union,         Types.Array(Types.Instance(Union))

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      bool_in_union: BoolInUnion.from_dynamic!(d.fetch("BoolInUnion")),
      union:         d.fetch("union").map { |x| Union.from_dynamic!(x) },
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "BoolInUnion" => bool_in_union.to_dynamic,
      "union"       => union.map { |x| x.to_dynamic },
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
