# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "[…]"
#   puts top_level.first.a
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

class A < Dry::Struct
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

class TopLevelElement < Dry::Struct
  attribute :a, Types.Instance(A).optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      a: d.key?("a") ? A.from_dynamic!(d["a"]) : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "a" => a&.to_dynamic,
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
