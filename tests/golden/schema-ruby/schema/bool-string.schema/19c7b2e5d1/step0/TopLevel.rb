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

  Nil    = Strict::Nil
  Bool   = Strict::Bool
  Hash   = Strict::Hash
  String = Strict::String
end

class UnionWithBool < Dry::Struct
  attribute :bool,   Types::Bool.optional
  attribute :string, Types::String.optional

  def self.from_dynamic!(d)
    if schema.key(:bool).type.right.valid? d
      return new(bool: d, string: nil)
    end
    if schema.key(:string).type.right.valid? d
      return new(string: d, bool: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if bool != nil
      bool
    elsif string != nil
      string
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel < Dry::Struct
  attribute :arr_nullable,             Types.Array(Types::String.optional).optional
  attribute :arr_one,                  Types.Array(Types::String).optional
  attribute :nullable,                 Types::String.optional
  attribute :one,                      Types::String
  attribute :top_level_optional,       Types::String.optional
  attribute :union_with_bool,          Types.Instance(UnionWithBool)
  attribute :union_with_bool_and_enum, Types.Instance(UnionWithBool)

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      arr_nullable:             d.key?("arrNullable") ? d["arrNullable"].map { |x| x } : nil,
      arr_one:                  d.key?("arrOne") ? d["arrOne"].map { |x| Types::String[x] } : nil,
      nullable:                 d.fetch("nullable"),
      one:                      d.fetch("one"),
      top_level_optional:       d.key?("optional") ? Types::String[d["optional"]] : nil,
      union_with_bool:          UnionWithBool.from_dynamic!(d.fetch("unionWithBool")),
      union_with_bool_and_enum: UnionWithBool.from_dynamic!(d.fetch("unionWithBoolAndEnum")),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "arrNullable"          => arr_nullable,
      "arrOne"               => arr_one,
      "nullable"             => nullable,
      "one"                  => one,
      "optional"             => top_level_optional,
      "unionWithBool"        => union_with_bool.to_dynamic,
      "unionWithBoolAndEnum" => union_with_bool_and_enum.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
