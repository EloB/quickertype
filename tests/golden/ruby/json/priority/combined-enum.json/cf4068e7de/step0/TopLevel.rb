# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.foo.first.x == X::Three
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry.Types(default: :nominal)

  Hash   = Strict::Hash
  String = Strict::String
  X      = Strict::String.enum("three", "one", "two")
end

module X
  Three = "three"
  One   = "one"
  Two   = "two"
end

class Bar < Dry::Struct
  attribute :x, Types::X

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      x: d.fetch("x"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "x" => x,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel < Dry::Struct
  attribute :bar, Types.Array(Bar)
  attribute :foo, Types.Array(Bar)

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      bar: d.fetch("bar").map { |x| Bar.from_dynamic!(x) },
      foo: d.fetch("foo").map { |x| Bar.from_dynamic!(x) },
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "bar" => bar.map { |x| x.to_dynamic },
      "foo" => foo.map { |x| x.to_dynamic },
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
