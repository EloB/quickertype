# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.date.even?
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry.Types(default: :nominal)

  Integer = Strict::Integer
  Bool    = Strict::Bool
  Hash    = Strict::Hash
  String  = Strict::String
end

class TopLevel < Dry::Struct
  attribute :date,     Types::Integer
  attribute :title,    Types::String
  attribute :validity, Types::Bool

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      date:     d.fetch("date"),
      title:    d.fetch("title"),
      validity: d.fetch("validity"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "date"     => date,
      "title"    => title,
      "validity" => validity,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
