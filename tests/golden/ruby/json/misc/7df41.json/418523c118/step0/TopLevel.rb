# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.xone.count.even?
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry.Types(default: :nominal)

  Integer = Strict::Integer
  Hash    = Strict::Hash
  String  = Strict::String
end

class PC < Dry::Struct
  attribute :count,  Types::Integer
  attribute :label,  Types::String
  attribute :peak24, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      count:  d.fetch("count"),
      label:  d.fetch("label"),
      peak24: d.fetch("peak24"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "count"  => count,
      "label"  => label,
      "peak24" => peak24,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel < Dry::Struct
  attribute :pc,   PC
  attribute :ps3,  PC
  attribute :ps4,  PC
  attribute :xbox, PC
  attribute :xone, PC

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      pc:   PC.from_dynamic!(d.fetch("pc")),
      ps3:  PC.from_dynamic!(d.fetch("ps3")),
      ps4:  PC.from_dynamic!(d.fetch("ps4")),
      xbox: PC.from_dynamic!(d.fetch("xbox")),
      xone: PC.from_dynamic!(d.fetch("xone")),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "pc"   => pc.to_dynamic,
      "ps3"  => ps3.to_dynamic,
      "ps4"  => ps4.to_dynamic,
      "xbox" => xbox.to_dynamic,
      "xone" => xone.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
