# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.weather.weather_meta.credit
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry.Types(default: :nominal)

  Hash   = Strict::Hash
  String = Strict::String
  Double = Strict::Float | Strict::Integer
end

class Status < Dry::Struct
  attribute :avg_delay,     Types::String
  attribute :closure_begin, Types::String
  attribute :closure_end,   Types::String
  attribute :end_time,      Types::String
  attribute :max_delay,     Types::String
  attribute :min_delay,     Types::String
  attribute :reason,        Types::String
  attribute :status_type,   Types::String
  attribute :trend,         Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      avg_delay:     d.fetch("avgDelay"),
      closure_begin: d.fetch("closureBegin"),
      closure_end:   d.fetch("closureEnd"),
      end_time:      d.fetch("endTime"),
      max_delay:     d.fetch("maxDelay"),
      min_delay:     d.fetch("minDelay"),
      reason:        d.fetch("reason"),
      status_type:   d.fetch("type"),
      trend:         d.fetch("trend"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "avgDelay"     => avg_delay,
      "closureBegin" => closure_begin,
      "closureEnd"   => closure_end,
      "endTime"      => end_time,
      "maxDelay"     => max_delay,
      "minDelay"     => min_delay,
      "reason"       => reason,
      "type"         => status_type,
      "trend"        => trend,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Meta < Dry::Struct
  attribute :credit,  Types::String
  attribute :updated, Types::String
  attribute :url,     Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      credit:  d.fetch("credit"),
      updated: d.fetch("updated"),
      url:     d.fetch("url"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "credit"  => credit,
      "updated" => updated,
      "url"     => url,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Weather < Dry::Struct
  attribute :temp,         Types::String
  attribute :visibility,   Types::Double
  attribute :weather,      Types::String
  attribute :weather_meta, Meta
  attribute :wind,         Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      temp:         d.fetch("temp"),
      visibility:   d.fetch("visibility"),
      weather:      d.fetch("weather"),
      weather_meta: Meta.from_dynamic!(d.fetch("meta")),
      wind:         d.fetch("wind"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "temp"       => temp,
      "visibility" => visibility,
      "weather"    => weather,
      "meta"       => weather_meta.to_dynamic,
      "wind"       => wind,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel < Dry::Struct
  attribute :city,           Types::String
  attribute :delay,          Types::String
  attribute :iata,           Types::String
  attribute :icao,           Types::String
  attribute :state,          Types::String
  attribute :status,         Status
  attribute :top_level_name, Types::String
  attribute :weather,        Weather

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      city:           d.fetch("city"),
      delay:          d.fetch("delay"),
      iata:           d.fetch("IATA"),
      icao:           d.fetch("ICAO"),
      state:          d.fetch("state"),
      status:         Status.from_dynamic!(d.fetch("status")),
      top_level_name: d.fetch("name"),
      weather:        Weather.from_dynamic!(d.fetch("weather")),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "city"    => city,
      "delay"   => delay,
      "IATA"    => iata,
      "ICAO"    => icao,
      "state"   => state,
      "status"  => status.to_dynamic,
      "name"    => top_level_name,
      "weather" => weather.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
