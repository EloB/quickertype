# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.results.first.group.code == Code::Sf
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry.Types(default: :nominal)

  Integer  = Strict::Integer
  Nil      = Strict::Nil
  Bool     = Strict::Bool
  Hash     = Strict::Hash
  String   = Strict::String
  Code     = Strict::String.enum("sf")
  English  = Strict::String.enum("SF")
  Thai     = Strict::String.enum("เอสเอฟ")
  Location = Strict::String.enum("", "5th Fl. Emporium")
  Tel      = Strict::String.enum("", "02-268-8899")
end

module Code
  Sf = "sf"
end

module English
  Sf = "SF"
end

module Thai
  เอสเอฟ = "เอสเอฟ"
end

class Group < Dry::Struct
  attribute :code,    Types::Code
  attribute :english, Types::English
  attribute :thai,    Types::Thai
  attribute :website, Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      code:    d.fetch("code"),
      english: d.fetch("english"),
      thai:    d.fetch("thai"),
      website: d.fetch("website"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "code"    => code,
      "english" => english,
      "thai"    => thai,
      "website" => website,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

module Location
  Empty            = ""
  The5ThFLEmporium = "5th Fl. Emporium"
end

module Tel
  Empty        = ""
  The022688899 = "02-268-8899"
end

class Result < Dry::Struct
  attribute :code,          Types::String
  attribute :english,       Types::String
  attribute :fav,           Types::Bool
  attribute :group,         Group
  attribute :location,      Types::Location
  attribute :min_screens,   Types::Integer
  attribute :num_views,     Types::Integer
  attribute :showtimes,     Types::String
  attribute :stars,         Types::Integer
  attribute :tel,           Types::Tel
  attribute :thai,          Types::String
  attribute :today_screens, Types::Integer
  attribute :url,           Types::String
  attribute :website,       Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      code:          d.fetch("code"),
      english:       d.fetch("english"),
      fav:           d.fetch("fav"),
      group:         Group.from_dynamic!(d.fetch("group")),
      location:      d.fetch("location"),
      min_screens:   d.fetch("min_screens"),
      num_views:     d.fetch("num_views"),
      showtimes:     d.fetch("showtimes"),
      stars:         d.fetch("stars"),
      tel:           d.fetch("tel"),
      thai:          d.fetch("thai"),
      today_screens: d.fetch("today_screens"),
      url:           d.fetch("url"),
      website:       d.fetch("website"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "code"          => code,
      "english"       => english,
      "fav"           => fav,
      "group"         => group.to_dynamic,
      "location"      => location,
      "min_screens"   => min_screens,
      "num_views"     => num_views,
      "showtimes"     => showtimes,
      "stars"         => stars,
      "tel"           => tel,
      "thai"          => thai,
      "today_screens" => today_screens,
      "url"           => url,
      "website"       => website,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel < Dry::Struct
  attribute :count,          Types::Integer
  attribute :previous,       Types::Nil
  attribute :results,        Types.Array(Result)
  attribute :top_level_next, Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      count:          d.fetch("count"),
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
      "previous" => previous,
      "results"  => results.map { |x| x.to_dynamic },
      "next"     => top_level_next,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
