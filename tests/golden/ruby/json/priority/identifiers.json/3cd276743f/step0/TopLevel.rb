# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.top_level_empty.y.even?
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

class TopLevelBla < Dry::Struct
  attribute :bar, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      bar: d.fetch("bar"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "bar" => bar,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Empty < Dry::Struct
  attribute :x, Types::Integer

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

class FooBla < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Foo < Dry::Struct
  attribute :bla,   FooBla
  attribute :empty, Types::Integer
  attribute :foo,   Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      bla:   FooBla.from_dynamic!(d.fetch("bla")),
      empty: d.fetch("_"),
      foo:   d.fetch("__"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "bla" => bla.to_dynamic,
      "_"   => empty,
      "__"  => foo,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class ThisIsAToughOne < Dry::Struct
  attribute :empty,               Types::Integer
  attribute :this_is_a_tough_one, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      empty:               d.fetch("\n\n\n"),
      this_is_a_tough_one: d.fetch("\""),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "\n\n\n" => empty,
      "\""     => this_is_a_tough_one,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class EmptyClass < Dry::Struct
  attribute :y, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      y: d.fetch("y"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "y" => y,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel < Dry::Struct
  attribute :bla,                 TopLevelBla
  attribute :empty,               Empty
  attribute :foo,                 Foo
  attribute :this_is_a_tough_one, ThisIsAToughOne
  attribute :top_level,           Types::Integer
  attribute :top_level_empty,     EmptyClass

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      bla:                 TopLevelBla.from_dynamic!(d.fetch("bla")),
      empty:               Empty.from_dynamic!(d.fetch("")),
      foo:                 Foo.from_dynamic!(d.fetch("foo")),
      this_is_a_tough_one: ThisIsAToughOne.from_dynamic!(d.fetch("ThisIsA\u{1f61c}Tough\"\n\nOne")),
      top_level:           d.fetch("!"),
      top_level_empty:     EmptyClass.from_dynamic!(d.fetch("Empty")),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "bla"                            => bla.to_dynamic,
      ""                               => empty.to_dynamic,
      "foo"                            => foo.to_dynamic,
      "ThisIsA\u{1f61c}Tough\"\n\nOne" => this_is_a_tough_one.to_dynamic,
      "!"                              => top_level,
      "Empty"                          => top_level_empty.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
