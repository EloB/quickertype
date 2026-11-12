# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.light_params.app_id
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

class LightParams < Dry::Struct
  attribute :app_id,    Types::String
  attribute :outlet_id, Types::String
  attribute :rgba,      Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      app_id:    d.fetch("app_id"),
      outlet_id: d.fetch("outlet_id"),
      rgba:      d.fetch("rgba"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "app_id"    => app_id,
      "outlet_id" => outlet_id,
      "rgba"      => rgba,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel < Dry::Struct
  attribute :light_params, LightParams

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      light_params: LightParams.from_dynamic!(d.fetch("LightParams")),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "LightParams" => light_params.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
