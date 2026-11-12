# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.query.results.channel.wind.chill
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
  Text    = Strict::String.enum("Mostly Cloudy", "Rain", "Partly Cloudy")
end

class Astronomy < Dry::Struct
  attribute :sunrise, Types::String
  attribute :sunset,  Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      sunrise: d.fetch("sunrise"),
      sunset:  d.fetch("sunset"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "sunrise" => sunrise,
      "sunset"  => sunset,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Atmosphere < Dry::Struct
  attribute :humidity,   Types::String
  attribute :pressure,   Types::String
  attribute :rising,     Types::String
  attribute :visibility, Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      humidity:   d.fetch("humidity"),
      pressure:   d.fetch("pressure"),
      rising:     d.fetch("rising"),
      visibility: d.fetch("visibility"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "humidity"   => humidity,
      "pressure"   => pressure,
      "rising"     => rising,
      "visibility" => visibility,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Image < Dry::Struct
  attribute :height, Types::String
  attribute :link,   Types::String
  attribute :title,  Types::String
  attribute :url,    Types::String
  attribute :width,  Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      height: d.fetch("height"),
      link:   d.fetch("link"),
      title:  d.fetch("title"),
      url:    d.fetch("url"),
      width:  d.fetch("width"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "height" => height,
      "link"   => link,
      "title"  => title,
      "url"    => url,
      "width"  => width,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

module Text
  MostlyCloudy = "Mostly Cloudy"
  Rain         = "Rain"
  PartlyCloudy = "Partly Cloudy"
end

class Condition < Dry::Struct
  attribute :code, Types::String
  attribute :date, Types::String
  attribute :temp, Types::String
  attribute :text, Types::Text

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      code: d.fetch("code"),
      date: d.fetch("date"),
      temp: d.fetch("temp"),
      text: d.fetch("text"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "code" => code,
      "date" => date,
      "temp" => temp,
      "text" => text,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Forecast < Dry::Struct
  attribute :code, Types::String
  attribute :date, Types::String
  attribute :day,  Types::String
  attribute :high, Types::String
  attribute :low,  Types::String
  attribute :text, Types::Text

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      code: d.fetch("code"),
      date: d.fetch("date"),
      day:  d.fetch("day"),
      high: d.fetch("high"),
      low:  d.fetch("low"),
      text: d.fetch("text"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "code" => code,
      "date" => date,
      "day"  => day,
      "high" => high,
      "low"  => low,
      "text" => text,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class GUID < Dry::Struct
  attribute :is_perma_link, Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      is_perma_link: d.fetch("isPermaLink"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "isPermaLink" => is_perma_link,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Item < Dry::Struct
  attribute :condition,   Condition
  attribute :description, Types::String
  attribute :forecast,    Types.Array(Forecast)
  attribute :guid,        GUID
  attribute :lat,         Types::String
  attribute :link,        Types::String
  attribute :long,        Types::String
  attribute :pub_date,    Types::String
  attribute :title,       Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      condition:   Condition.from_dynamic!(d.fetch("condition")),
      description: d.fetch("description"),
      forecast:    d.fetch("forecast").map { |x| Forecast.from_dynamic!(x) },
      guid:        GUID.from_dynamic!(d.fetch("guid")),
      lat:         d.fetch("lat"),
      link:        d.fetch("link"),
      long:        d.fetch("long"),
      pub_date:    d.fetch("pubDate"),
      title:       d.fetch("title"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "condition"   => condition.to_dynamic,
      "description" => description,
      "forecast"    => forecast.map { |x| x.to_dynamic },
      "guid"        => guid.to_dynamic,
      "lat"         => lat,
      "link"        => link,
      "long"        => long,
      "pubDate"     => pub_date,
      "title"       => title,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Location < Dry::Struct
  attribute :city,    Types::String
  attribute :country, Types::String
  attribute :region,  Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      city:    d.fetch("city"),
      country: d.fetch("country"),
      region:  d.fetch("region"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "city"    => city,
      "country" => country,
      "region"  => region,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Units < Dry::Struct
  attribute :distance,    Types::String
  attribute :pressure,    Types::String
  attribute :speed,       Types::String
  attribute :temperature, Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      distance:    d.fetch("distance"),
      pressure:    d.fetch("pressure"),
      speed:       d.fetch("speed"),
      temperature: d.fetch("temperature"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "distance"    => distance,
      "pressure"    => pressure,
      "speed"       => speed,
      "temperature" => temperature,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Wind < Dry::Struct
  attribute :chill,     Types::String
  attribute :direction, Types::String
  attribute :speed,     Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      chill:     d.fetch("chill"),
      direction: d.fetch("direction"),
      speed:     d.fetch("speed"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "chill"     => chill,
      "direction" => direction,
      "speed"     => speed,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Channel < Dry::Struct
  attribute :astronomy,       Astronomy
  attribute :atmosphere,      Atmosphere
  attribute :description,     Types::String
  attribute :image,           Image
  attribute :item,            Item
  attribute :language,        Types::String
  attribute :last_build_date, Types::String
  attribute :link,            Types::String
  attribute :location,        Location
  attribute :title,           Types::String
  attribute :ttl,             Types::String
  attribute :units,           Units
  attribute :wind,            Wind

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      astronomy:       Astronomy.from_dynamic!(d.fetch("astronomy")),
      atmosphere:      Atmosphere.from_dynamic!(d.fetch("atmosphere")),
      description:     d.fetch("description"),
      image:           Image.from_dynamic!(d.fetch("image")),
      item:            Item.from_dynamic!(d.fetch("item")),
      language:        d.fetch("language"),
      last_build_date: d.fetch("lastBuildDate"),
      link:            d.fetch("link"),
      location:        Location.from_dynamic!(d.fetch("location")),
      title:           d.fetch("title"),
      ttl:             d.fetch("ttl"),
      units:           Units.from_dynamic!(d.fetch("units")),
      wind:            Wind.from_dynamic!(d.fetch("wind")),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "astronomy"     => astronomy.to_dynamic,
      "atmosphere"    => atmosphere.to_dynamic,
      "description"   => description,
      "image"         => image.to_dynamic,
      "item"          => item.to_dynamic,
      "language"      => language,
      "lastBuildDate" => last_build_date,
      "link"          => link,
      "location"      => location.to_dynamic,
      "title"         => title,
      "ttl"           => ttl,
      "units"         => units.to_dynamic,
      "wind"          => wind.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Results < Dry::Struct
  attribute :channel, Channel

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      channel: Channel.from_dynamic!(d.fetch("channel")),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "channel" => channel.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Query < Dry::Struct
  attribute :count,   Types::Integer
  attribute :created, Types::String.constrained(format: /\A\d{4}-\d\d-\d\dT\d\d:\d\d:\d\d(?:\.\d+)?(?:Z|[+-]\d\d:\d\d)\z/i)
  attribute :lang,    Types::String
  attribute :results, Results

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      count:   d.fetch("count"),
      created: d.fetch("created"),
      lang:    d.fetch("lang"),
      results: Results.from_dynamic!(d.fetch("results")),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "count"   => count,
      "created" => created,
      "lang"    => lang,
      "results" => results.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel < Dry::Struct
  attribute :query, Query

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      query: Query.from_dynamic!(d.fetch("query")),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "query" => query.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
