# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.top_level_name
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry.Types(default: :nominal)

  Hash     = Strict::Hash
  String   = Strict::String
  Shortcut = Strict::String.enum("hidden", "visible")
end

module Shortcut
  Hidden  = "hidden"
  Visible = "visible"
end

class TopLevel < Dry::Struct
  attribute :top_level_name, Types::String
  attribute :shortcut,       Types::Shortcut.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      top_level_name: d.fetch("name"),
      shortcut:       d.key?("shortcut") ? Types::Shortcut[d["shortcut"]] : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "name"     => top_level_name,
      "shortcut" => shortcut,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
