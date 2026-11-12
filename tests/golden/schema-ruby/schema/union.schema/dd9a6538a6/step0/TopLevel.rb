# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "[…]"
#   puts top_level.first.one.even?
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
  Double  = Strict::Float | Strict::Integer
end

class TopLevelElement < Dry::Struct
  attribute :one,   Types::Integer.optional
  attribute :two,   Types::Bool
  attribute :three, Types::Double.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      one:   d.key?("one") ? Types::Integer[d["one"]] : nil,
      two:   d.fetch("two"),
      three: d.key?("three") ? Types::Double[d["three"]] : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "one"   => one,
      "two"   => two,
      "three" => three,
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
