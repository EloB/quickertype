# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.top_level_options.first.foo
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry.Types(default: :nominal)

  Hash   = Strict::Hash
  String = Strict::String
end

class Option < Dry::Struct
  attribute :foo,         Types::String.optional
  attribute :option_name, Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      foo:         d.key?("foo") ? Types::String[d["foo"]] : nil,
      option_name: d.fetch("name"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "foo"  => foo,
      "name" => option_name,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel < Dry::Struct
  attribute :top_level_options, Types.Array(Option)

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      top_level_options: d.fetch("options").map { |x| Option.from_dynamic!(x) },
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "options" => top_level_options.map { |x| x.to_dynamic },
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
