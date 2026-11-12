# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.also&.also&.also&.also&.also&.also
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
  attribute :also, TopLevel.optional
  attribute :bar,  Types::Bool
  attribute :foo,  Types::Integer
  attribute :moo,  Types::Double
  attribute :quux, Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      also: d.key?("also") ? TopLevel.from_dynamic!(d["also"]) : nil,
      bar:  d.fetch("bar"),
      foo:  d.fetch("foo"),
      moo:  d.fetch("moo"),
      quux: d.fetch("quux"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "also" => also&.to_dynamic,
      "bar"  => bar,
      "foo"  => foo,
      "moo"  => moo,
      "quux" => quux,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
