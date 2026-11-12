# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level["…"].channel_id
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

class TopLevelValue < Dry::Struct
  attribute :channel_id,   Types::String
  attribute :channel_name, Types::String
  attribute :code,         Types::String
  attribute :emoticon_set, Types::Integer
  attribute :id,           Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      channel_id:   d.fetch("channel_id"),
      channel_name: d.fetch("channel_name"),
      code:         d.fetch("code"),
      emoticon_set: d.fetch("emoticon_set"),
      id:           d.fetch("id"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "channel_id"   => channel_id,
      "channel_name" => channel_name,
      "code"         => code,
      "emoticon_set" => emoticon_set,
      "id"           => id,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel
  def self.from_json!(json)
    Types::Hash[JSON.parse(json, quirks_mode: true)].map { |k, v| [k, TopLevelValue.from_dynamic!(v)] }.to_h
  end
end
