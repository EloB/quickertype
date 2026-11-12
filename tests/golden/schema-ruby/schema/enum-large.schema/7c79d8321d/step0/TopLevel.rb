# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.callsign == Callsign::Alpha
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry.Types(default: :nominal)

  Hash     = Strict::Hash
  String   = Strict::String
  Callsign = Strict::String.enum("alpha", "bravo", "charlie", "delta", "echo", "foxtrot", "golf", "hotel", "india", "juliett", "kilo", "lima", "mike", "november", "oscar", "papa", "quebec", "romeo", "sierra", "tango")
  Priority = Strict::String.enum("low", "medium", "high")
end

module Callsign
  Alpha    = "alpha"
  Bravo    = "bravo"
  Charlie  = "charlie"
  Delta    = "delta"
  Echo     = "echo"
  Foxtrot  = "foxtrot"
  Golf     = "golf"
  Hotel    = "hotel"
  India    = "india"
  Juliett  = "juliett"
  Kilo     = "kilo"
  Lima     = "lima"
  Mike     = "mike"
  November = "november"
  Oscar    = "oscar"
  Papa     = "papa"
  Quebec   = "quebec"
  Romeo    = "romeo"
  Sierra   = "sierra"
  Tango    = "tango"
end

module Priority
  Low    = "low"
  Medium = "medium"
  High   = "high"
end

class TopLevel < Dry::Struct
  attribute :callsign, Types::Callsign
  attribute :priority, Types::Priority

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      callsign: d.fetch("callsign"),
      priority: d.fetch("priority"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "callsign" => callsign,
      "priority" => priority,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
