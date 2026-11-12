# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.results.first.created_at
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry.Types(default: :nominal)

  Integer = Strict::Integer
  Nil     = Strict::Nil
  Bool    = Strict::Bool
  Hash    = Strict::Hash
  String  = Strict::String
end

class Facets < Dry::Struct

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

class Result < Dry::Struct
  attribute :created_at,  Types::String.constrained(format: /\A\d{4}-\d\d-\d\dT\d\d:\d\d:\d\d(?:\.\d+)?(?:Z|[+-]\d\d:\d\d)\z/i)
  attribute :id,          Types::Integer
  attribute :items,       Types::Integer
  attribute :parent,      Types::Integer.optional
  attribute :result_name, Types::String
  attribute :updated_at,  Types::String.constrained(format: /\A\d{4}-\d\d-\d\dT\d\d:\d\d:\d\d(?:\.\d+)?(?:Z|[+-]\d\d:\d\d)\z/i)
  attribute :uri,         Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      created_at:  d.fetch("created_at"),
      id:          d.fetch("id"),
      items:       d.fetch("items"),
      parent:      d.fetch("parent"),
      result_name: d.fetch("name"),
      updated_at:  d.fetch("updated_at"),
      uri:         d.fetch("uri"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "created_at" => created_at,
      "id"         => id,
      "items"      => items,
      "parent"     => parent,
      "name"       => result_name,
      "updated_at" => updated_at,
      "uri"        => uri,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel < Dry::Struct
  attribute :count,          Types::Integer
  attribute :facets,         Facets
  attribute :limit,          Types::Integer
  attribute :offset,         Types::Integer
  attribute :previous,       Types::Bool
  attribute :results,        Types.Array(Result)
  attribute :top_level_next, Types::Bool

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      count:          d.fetch("count"),
      facets:         Facets.from_dynamic!(d.fetch("facets")),
      limit:          d.fetch("limit"),
      offset:         d.fetch("offset"),
      previous:       d.fetch("previous"),
      results:        d.fetch("results").map { |x| Result.from_dynamic!(x) },
      top_level_next: d.fetch("next"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "count"    => count,
      "facets"   => facets.to_dynamic,
      "limit"    => limit,
      "offset"   => offset,
      "previous" => previous,
      "results"  => results.map { |x| x.to_dynamic },
      "next"     => top_level_next,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
