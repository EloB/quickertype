# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "[…]"
#   puts top_level.first.age.even?
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
  Country = Strict::String.enum("United States")
end

module Country
  UnitedStates = "United States"
end

class TopLevelElement < Dry::Struct
  attribute :age,     Types::Integer
  attribute :country, Types::Country
  attribute :females, Types::Integer
  attribute :males,   Types::Integer
  attribute :total,   Types::Integer
  attribute :year,    Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      age:     d.fetch("age"),
      country: d.fetch("country"),
      females: d.fetch("females"),
      males:   d.fetch("males"),
      total:   d.fetch("total"),
      year:    d.fetch("year"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "age"     => age,
      "country" => country,
      "females" => females,
      "males"   => males,
      "total"   => total,
      "year"    => year,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel
  def self.from_json!(json)
    top_level = JSON.parse(json, quirks_mode: true).map { |x| TopLevelElement.from_dynamic!(x) }
    top_level.define_singleton_method(:to_json) do
      JSON.generate(self.map { |x| x.to_dynamic })
    end
    top_level
  end
end
