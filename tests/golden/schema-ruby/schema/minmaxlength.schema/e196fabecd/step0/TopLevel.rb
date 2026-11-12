# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.intersection
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry.Types(default: :nominal)

  Hash   = Strict::Hash
  String = Strict::String
  Double = Strict::Float | Strict::Integer
end

class InUnion < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :string, Types::String.constrained(min_size: 3, max_size: 5).optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, string: nil)
    end
    if schema.key(:string).type.right.valid? d
      return new(string: d, double: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif string != nil
      string
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel < Dry::Struct
  attribute :intersection,         Types::String.constrained(min_size: 4, max_size: 5)
  attribute :in_union,             Types.Instance(InUnion)
  attribute :maxlength,            Types::String.constrained(max_size: 5)
  attribute :minlength,            Types::String.constrained(min_size: 3)
  attribute :min_max_intersection, Types::String.constrained(min_size: 3, max_size: 5)
  attribute :minmaxlength,         Types::String.constrained(min_size: 3, max_size: 5)
  attribute :min_max_union,        Types::String
  attribute :union,                Types::String.constrained(min_size: 3, max_size: 6)

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      intersection:         d.fetch("intersection"),
      in_union:             InUnion.from_dynamic!(d.fetch("inUnion")),
      maxlength:            d.fetch("maxlength"),
      minlength:            d.fetch("minlength"),
      min_max_intersection: d.fetch("minMaxIntersection"),
      minmaxlength:         d.fetch("minmaxlength"),
      min_max_union:        d.fetch("minMaxUnion"),
      union:                d.fetch("union"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "intersection"       => intersection,
      "inUnion"            => in_union.to_dynamic,
      "maxlength"          => maxlength,
      "minlength"          => minlength,
      "minMaxIntersection" => min_max_intersection,
      "minmaxlength"       => minmaxlength,
      "minMaxUnion"        => min_max_union,
      "union"              => union,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
