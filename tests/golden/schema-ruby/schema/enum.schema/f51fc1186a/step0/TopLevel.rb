# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.other_arr&.first == OtherArr::Foo
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry.Types(default: :nominal)

  Integer  = Strict::Integer
  Hash     = Strict::Hash
  String   = Strict::String
  OtherArr = Strict::String.enum("foo", "bar", "if")
  Gve      = Strict::String.enum("good", "neutral", "evil")
  Lvc      = Strict::String.enum("lawful", "neutral", "chaotic")
end

module OtherArr
  Foo = "foo"
  Bar = "bar"
  If  = "if"
end

class Arr < Dry::Struct
  attribute :enum_1,  Types::OtherArr.optional
  attribute :integer, Types::Integer.optional

  def self.from_dynamic!(d)
    if schema.key(:enum_1).type.right.valid? d
      return new(enum_1: d, integer: nil)
    end
    if schema.key(:integer).type.right.valid? d
      return new(integer: d, enum_1: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if enum_1 != nil
      enum_1
    elsif integer != nil
      integer
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

module Gve
  Good    = "good"
  Neutral = "neutral"
  Evil    = "evil"
end

module Lvc
  Lawful  = "lawful"
  Neutral = "neutral"
  Chaotic = "chaotic"
end

class TopLevel < Dry::Struct
  attribute :arr,           Types.Array(Types.Instance(Arr)).optional
  attribute :top_level_for, Types::String.optional
  attribute :gve,           Types::Gve
  attribute :lvc,           Types::Lvc.optional
  attribute :other_arr,     Types.Array(Types::OtherArr).optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      arr:           d.key?("arr") ? d["arr"].map { |x| Arr.from_dynamic!(x) } : nil,
      top_level_for: d.key?("for") ? Types::String[d["for"]] : nil,
      gve:           d.fetch("gve"),
      lvc:           d.key?("lvc") ? Types::Lvc[d["lvc"]] : nil,
      other_arr:     d.key?("otherArr") ? d["otherArr"].map { |x| Types::OtherArr[x] } : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "arr"      => arr&.map { |x| x.to_dynamic },
      "for"      => top_level_for,
      "gve"      => gve,
      "lvc"      => lvc,
      "otherArr" => other_arr,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
