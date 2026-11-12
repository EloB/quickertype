# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.weekdays == Weekdays::Monday
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry.Types(default: :nominal)

  Hash     = Strict::Hash
  String   = Strict::String
  Weekdays = Strict::String.enum("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday")
end

module Weekdays
  Monday    = "Monday"
  Tuesday   = "Tuesday"
  Wednesday = "Wednesday"
  Thursday  = "Thursday"
  Friday    = "Friday"
  Saturday  = "Saturday"
  Sunday    = "Sunday"
end

class TopLevel < Dry::Struct
  attribute :weekdays, Types::Weekdays

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      weekdays: d.fetch("weekdays"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "weekdays" => weekdays,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
