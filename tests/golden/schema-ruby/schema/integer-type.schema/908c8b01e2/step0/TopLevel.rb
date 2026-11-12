# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.above_i32_max.even?
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry.Types(default: :nominal)

  Integer = Strict::Integer
  Hash    = Strict::Hash
end

class TopLevel < Dry::Struct
  attribute :above_i32_max,  Types::Integer.constrained(gteq: 0, lteq: 2147483648)
  attribute :below_i32_min,  Types::Integer.constrained(gteq: -2147483649, lteq: 0)
  attribute :i32_range,      Types::Integer.constrained(gteq: -2147483648, lteq: 2147483647)
  attribute :large_bounds,   Types::Integer.constrained(gteq: -9007199254740991, lteq: 9007199254740991)
  attribute :only_maximum,   Types::Integer.constrained(lteq: 0)
  attribute :only_minimum,   Types::Integer.constrained(gteq: 0)
  attribute :small_negative, Types::Integer.constrained(gteq: -100, lteq: 0)
  attribute :small_positive, Types::Integer.constrained(gteq: 0, lteq: 100)
  attribute :unbounded,      Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      above_i32_max:  d.fetch("above_i32_max"),
      below_i32_min:  d.fetch("below_i32_min"),
      i32_range:      d.fetch("i32_range"),
      large_bounds:   d.fetch("large_bounds"),
      only_maximum:   d.fetch("only_maximum"),
      only_minimum:   d.fetch("only_minimum"),
      small_negative: d.fetch("small_negative"),
      small_positive: d.fetch("small_positive"),
      unbounded:      d.fetch("unbounded"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "above_i32_max"  => above_i32_max,
      "below_i32_min"  => below_i32_min,
      "i32_range"      => i32_range,
      "large_bounds"   => large_bounds,
      "only_maximum"   => only_maximum,
      "only_minimum"   => only_minimum,
      "small_negative" => small_negative,
      "small_positive" => small_positive,
      "unbounded"      => unbounded,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
