# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "[…]"
#   puts top_level.first.outcome_status.category
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

class Street < Dry::Struct
  attribute :id,          Types::Integer
  attribute :street_name, Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      id:          d.fetch("id"),
      street_name: d.fetch("name"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "id"   => id,
      "name" => street_name,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Location < Dry::Struct
  attribute :latitude,  Types::String
  attribute :longitude, Types::String
  attribute :street,    Street

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      latitude:  d.fetch("latitude"),
      longitude: d.fetch("longitude"),
      street:    Street.from_dynamic!(d.fetch("street")),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "latitude"  => latitude,
      "longitude" => longitude,
      "street"    => street.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class OutcomeStatus < Dry::Struct
  attribute :category, Types::String
  attribute :date,     Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      category: d.fetch("category"),
      date:     d.fetch("date"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "category" => category,
      "date"     => date,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevelElement < Dry::Struct
  attribute :category,         Types::String
  attribute :context,          Types::String
  attribute :id,               Types::Integer
  attribute :location,         Location
  attribute :location_subtype, Types::String
  attribute :location_type,    Types::String
  attribute :month,            Types::String
  attribute :outcome_status,   OutcomeStatus
  attribute :persistent_id,    Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      category:         d.fetch("category"),
      context:          d.fetch("context"),
      id:               d.fetch("id"),
      location:         Location.from_dynamic!(d.fetch("location")),
      location_subtype: d.fetch("location_subtype"),
      location_type:    d.fetch("location_type"),
      month:            d.fetch("month"),
      outcome_status:   OutcomeStatus.from_dynamic!(d.fetch("outcome_status")),
      persistent_id:    d.fetch("persistent_id"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "category"         => category,
      "context"          => context,
      "id"               => id,
      "location"         => location.to_dynamic,
      "location_subtype" => location_subtype,
      "location_type"    => location_type,
      "month"            => month,
      "outcome_status"   => outcome_status.to_dynamic,
      "persistent_id"    => persistent_id,
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
