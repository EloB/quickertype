# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.union_items.first
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
  Double  = Strict::Float | Strict::Integer
end

class UnionItem < Dry::Struct
  attribute :integer, Types::Integer.optional
  attribute :string,  Types::String.optional

  def self.from_dynamic!(d)
    if schema.key(:integer).type.right.valid? d
      return new(integer: d, string: nil)
    end
    if schema.key(:string).type.right.valid? d
      return new(string: d, integer: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if integer != nil
      integer
    elsif string != nil
      string
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel < Dry::Struct
  attribute :max_only,    Types.Array(Types::Integer).constrained(max_size: 3)
  attribute :min_and_max, Types.Array(Types::Double).constrained(min_size: 1, max_size: 4)
  attribute :min_only,    Types.Array(Types::String).constrained(min_size: 2)
  attribute :plain,       Types.Array(Types::String)
  attribute :union_items, Types.Array(Types.Instance(UnionItem)).constrained(min_size: 2)

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      max_only:    d.fetch("maxOnly"),
      min_and_max: d.fetch("minAndMax"),
      min_only:    d.fetch("minOnly"),
      plain:       d.fetch("plain"),
      union_items: d.fetch("unionItems").map { |x| UnionItem.from_dynamic!(x) },
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "maxOnly"    => max_only,
      "minAndMax"  => min_and_max,
      "minOnly"    => min_only,
      "plain"      => plain,
      "unionItems" => union_items.map { |x| x.to_dynamic },
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
