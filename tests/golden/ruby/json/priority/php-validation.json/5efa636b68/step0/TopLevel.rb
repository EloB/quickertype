# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.integers.first.even?
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
  String  = Strict::String
  Double  = Strict::Float | Strict::Integer
end

class TopLevel < Dry::Struct
  attribute :boolean,  Types::Bool
  attribute :integer,  Types::Integer
  attribute :integers, Types.Array(Types::Integer)
  attribute :number,   Types::Double
  attribute :string,   Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      boolean:  d.fetch("boolean"),
      integer:  d.fetch("integer"),
      integers: d.fetch("integers"),
      number:   d.fetch("number"),
      string:   d.fetch("string"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "boolean"  => boolean,
      "integer"  => integer,
      "integers" => integers,
      "number"   => number,
      "string"   => string,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
