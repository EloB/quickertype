# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.arr_one&.first
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry.Types(default: :nominal)

  Nil               = Strict::Nil
  Hash              = Strict::Hash
  String            = Strict::String
  UnionWithEnumEnum = Strict::String.enum("foo")
end

module UnionWithEnumEnum
  Foo = "foo"
end

class UnionWithEnumUnion < Dry::Struct
  attribute :enum_1, Types::UnionWithEnumEnum.optional
  attribute :uuid,   Types::String.constrained(format: /\A[0-9a-f]{8}-(?:[0-9a-f]{4}-){3}[0-9a-f]{12}\z/i).optional

  def self.from_dynamic!(d)
    if schema.key(:enum_1).type.right.valid? d
      return new(enum_1: d, uuid: nil)
    end
    if schema.key(:uuid).type.right.valid? d
      return new(uuid: d, enum_1: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if enum_1 != nil
      enum_1
    elsif uuid != nil
      uuid
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel < Dry::Struct
  attribute :arr_nullable,       Types.Array(Types::String.constrained(format: /\A[0-9a-f]{8}-(?:[0-9a-f]{4}-){3}[0-9a-f]{12}\z/i).optional).optional
  attribute :arr_one,            Types.Array(Types::String.constrained(format: /\A[0-9a-f]{8}-(?:[0-9a-f]{4}-){3}[0-9a-f]{12}\z/i)).optional
  attribute :nullable,           Types::String.constrained(format: /\A[0-9a-f]{8}-(?:[0-9a-f]{4}-){3}[0-9a-f]{12}\z/i).optional
  attribute :one,                Types::String.constrained(format: /\A[0-9a-f]{8}-(?:[0-9a-f]{4}-){3}[0-9a-f]{12}\z/i)
  attribute :top_level_optional, Types::String.constrained(format: /\A[0-9a-f]{8}-(?:[0-9a-f]{4}-){3}[0-9a-f]{12}\z/i).optional
  attribute :union_with_enum,    Types.Instance(UnionWithEnumUnion)

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      arr_nullable:       d.key?("arrNullable") ? d["arrNullable"].map { |x| x } : nil,
      arr_one:            d.key?("arrOne") ? d["arrOne"].map { |x| Types::String.constrained(format: /\A[0-9a-f]{8}-(?:[0-9a-f]{4}-){3}[0-9a-f]{12}\z/i)[x] } : nil,
      nullable:           d.fetch("nullable"),
      one:                d.fetch("one"),
      top_level_optional: d.key?("optional") ? Types::String.constrained(format: /\A[0-9a-f]{8}-(?:[0-9a-f]{4}-){3}[0-9a-f]{12}\z/i)[d["optional"]] : nil,
      union_with_enum:    UnionWithEnumUnion.from_dynamic!(d.fetch("unionWithEnum")),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "arrNullable"   => arr_nullable,
      "arrOne"        => arr_one,
      "nullable"      => nullable,
      "one"           => one,
      "optional"      => top_level_optional,
      "unionWithEnum" => union_with_enum.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
