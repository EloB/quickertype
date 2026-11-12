# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.values["…"]
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry.Types(default: :nominal)

  Hash = Strict::Hash
end

class TopLevel < Dry::Struct
  attribute :foo,    Types::Any
  attribute :values, Types::Hash.meta(of: Types::Any)

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      foo:    d.fetch("foo"),
      values: Types::Hash[d.fetch("values")].map { |k, v| [k, Types::Any[v]] }.to_h,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "foo"    => foo,
      "values" => values,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
