# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.optional_date
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

class TopLevel < Dry::Struct
  attribute :optional_date,      Types::String.optional
  attribute :optional_date_time, Types::String.constrained(format: /\A\d{4}-\d\d-\d\dT\d\d:\d\d:\d\d(?:\.\d+)?(?:Z|[+-]\d\d:\d\d)\z/i).optional
  attribute :optional_time,      Types::String.optional
  attribute :required_date,      Types::String
  attribute :required_date_time, Types::String.constrained(format: /\A\d{4}-\d\d-\d\dT\d\d:\d\d:\d\d(?:\.\d+)?(?:Z|[+-]\d\d:\d\d)\z/i)
  attribute :required_time,      Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      optional_date:      d.key?("optional-date") ? Types::String[d["optional-date"]] : nil,
      optional_date_time: d.key?("optional-date-time") ? Types::String.constrained(format: /\A\d{4}-\d\d-\d\dT\d\d:\d\d:\d\d(?:\.\d+)?(?:Z|[+-]\d\d:\d\d)\z/i)[d["optional-date-time"]] : nil,
      optional_time:      d.key?("optional-time") ? Types::String[d["optional-time"]] : nil,
      required_date:      d.fetch("required-date"),
      required_date_time: d.fetch("required-date-time"),
      required_time:      d.fetch("required-time"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "optional-date"      => optional_date,
      "optional-date-time" => optional_date_time,
      "optional-time"      => optional_time,
      "required-date"      => required_date,
      "required-date-time" => required_date_time,
      "required-time"      => required_time,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
