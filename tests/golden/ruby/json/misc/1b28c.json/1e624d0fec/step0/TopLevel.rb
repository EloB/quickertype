# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.total_population.first.date
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

class TotalPopulation < Dry::Struct
  attribute :date,       Types::String
  attribute :population, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      date:       d.fetch("date"),
      population: d.fetch("population"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "date"       => date,
      "population" => population,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel < Dry::Struct
  attribute :total_population, Types.Array(TotalPopulation)

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      total_population: d.fetch("total_population").map { |x| TotalPopulation.from_dynamic!(x) },
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "total_population" => total_population.map { |x| x.to_dynamic },
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
