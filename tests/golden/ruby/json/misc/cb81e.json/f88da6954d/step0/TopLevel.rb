# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.description.base_period
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

class Description < Dry::Struct
  attribute :base_period, Types::String
  attribute :missing,     Types::String
  attribute :title,       Types::String
  attribute :units,       Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      base_period: d.fetch("base_period"),
      missing:     d.fetch("missing"),
      title:       d.fetch("title"),
      units:       d.fetch("units"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "base_period" => base_period,
      "missing"     => missing,
      "title"       => title,
      "units"       => units,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel < Dry::Struct
  attribute :data,        Types::Hash.meta(of: Types::String)
  attribute :description, Description

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      data:        Types::Hash[d.fetch("data")].map { |k, v| [k, Types::String[v]] }.to_h,
      description: Description.from_dynamic!(d.fetch("description")),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "data"        => data,
      "description" => description.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
