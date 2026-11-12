# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.bar&.foo
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry.Types(default: :nominal)

  Hash = Strict::Hash
end

# (forward declaration)
class Bar < Dry::Struct; end

# (forward declaration)
class TopLevel < Dry::Struct; end

class Foo < Dry::Struct
  attribute :top_level,       TopLevel.optional
  attribute :top_level_array, Types.Array(TopLevel).optional

  def self.from_dynamic!(d)
    begin
      value = TopLevel.from_dynamic!(d)
      if schema.key(:top_level).type.right.valid? value
        return new(top_level: value, top_level_array: nil)
      end
    rescue
    end
    begin
      value = d.map { |x| TopLevel.from_dynamic!(x) }
      if schema.key(:top_level_array).type.right.valid? value
        return new(top_level_array: value, top_level: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if top_level != nil
      top_level.to_dynamic
    elsif top_level_array != nil
      top_level_array.map { |x| x.to_dynamic }
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Bar < Dry::Struct
  attribute :foo, Types.Instance(Foo)

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      foo: Foo.from_dynamic!(d.fetch("foo")),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "foo" => foo.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel < Dry::Struct
  attribute :bar, Bar.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      bar: d.key?("bar") ? Bar.from_dynamic!(d["bar"]) : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "bar" => bar&.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
