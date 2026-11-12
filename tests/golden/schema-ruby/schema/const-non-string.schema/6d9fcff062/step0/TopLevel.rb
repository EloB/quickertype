# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.amount.even?
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
  Double  = Strict::Float | Strict::Integer
  Kind    = Strict::String.enum("widget")
end

module Kind
  Widget = "widget"
end

class TopLevel < Dry::Struct
  attribute :amount,  Types::Integer
  attribute :enabled, Types::Bool
  attribute :kind,    Types::Kind
  attribute :ratio,   Types::Double
  attribute :version, Types::Double

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      amount:  d.fetch("amount"),
      enabled: d.fetch("enabled"),
      kind:    d.fetch("kind"),
      ratio:   d.fetch("ratio"),
      version: d.fetch("version"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "amount"  => amount,
      "enabled" => enabled,
      "kind"    => kind,
      "ratio"   => ratio,
      "version" => version,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
