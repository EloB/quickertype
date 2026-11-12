# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.free.even?
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
  attribute :free,                 Types::Integer
  attribute :intersection,         Types::Integer.constrained(gteq: 4, lteq: 5)
  attribute :max,                  Types::Integer.constrained(lteq: 5)
  attribute :min,                  Types::Integer.constrained(gteq: 3)
  attribute :minmax,               Types::Integer.constrained(gteq: 3, lteq: 5)
  attribute :min_max_intersection, Types::Integer.constrained(gteq: 3, lteq: 5)
  attribute :min_max_union,        Types::Integer
  attribute :union,                Types::Integer.constrained(gteq: 3, lteq: 6)

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      free:                 d.fetch("free"),
      intersection:         d.fetch("intersection"),
      max:                  d.fetch("max"),
      min:                  d.fetch("min"),
      minmax:               d.fetch("minmax"),
      min_max_intersection: d.fetch("minMaxIntersection"),
      min_max_union:        d.fetch("minMaxUnion"),
      union:                d.fetch("union"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "free"               => free,
      "intersection"       => intersection,
      "max"                => max,
      "min"                => min,
      "minmax"             => minmax,
      "minMaxIntersection" => min_max_intersection,
      "minMaxUnion"        => min_max_union,
      "union"              => union,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
