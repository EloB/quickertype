# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.health == Health::Ok
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry.Types(default: :nominal)

  Hash   = Strict::Hash
  String = Strict::String
  Health = Strict::String.enum("ok", "error")
end

module Health
  Ok    = "ok"
  Error = "error"
end

class TopLevel < Dry::Struct
  attribute :health, Types::Health

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      health: d.fetch("health"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "health" => health,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
