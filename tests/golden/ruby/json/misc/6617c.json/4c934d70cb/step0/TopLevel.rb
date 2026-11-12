# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.iss_position.latitude
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

class IssPosition < Dry::Struct
  attribute :latitude,  Types::String
  attribute :longitude, Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      latitude:  d.fetch("latitude"),
      longitude: d.fetch("longitude"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "latitude"  => latitude,
      "longitude" => longitude,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel < Dry::Struct
  attribute :iss_position, IssPosition
  attribute :message,      Types::String
  attribute :timestamp,    Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      iss_position: IssPosition.from_dynamic!(d.fetch("iss_position")),
      message:      d.fetch("message"),
      timestamp:    d.fetch("timestamp"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "iss_position" => iss_position.to_dynamic,
      "message"      => message,
      "timestamp"    => timestamp,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
