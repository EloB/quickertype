# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.bar
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry.Types(default: :nominal)

  Hash    = Strict::Hash
  String  = Strict::String
  BarEnum = Strict::String.enum("quux")
end

module BarEnum
  Quux = "quux"
end

class BarUnion < Dry::Struct
  attribute :date_time, Types::String.constrained(format: /\A\d{4}-\d\d-\d\dT\d\d:\d\d:\d\d(?:\.\d+)?(?:Z|[+-]\d\d:\d\d)\z/i).optional
  attribute :enum_1,    Types::BarEnum.optional

  def self.from_dynamic!(d)
    if schema.key(:date_time).type.right.valid? d
      return new(date_time: d, enum_1: nil)
    end
    if schema.key(:enum_1).type.right.valid? d
      return new(enum_1: d, date_time: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if date_time != nil
      date_time
    elsif enum_1 != nil
      enum_1
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel < Dry::Struct
  attribute :bar, Types.Instance(BarUnion)
  attribute :foo, Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      bar: BarUnion.from_dynamic!(d.fetch("bar")),
      foo: d.fetch("foo"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "bar" => bar.to_dynamic,
      "foo" => foo,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
