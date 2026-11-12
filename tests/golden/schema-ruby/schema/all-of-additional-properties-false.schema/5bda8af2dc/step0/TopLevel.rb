# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.amount
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry.Types(default: :nominal)

  Hash      = Strict::Hash
  String    = Strict::String
  Double    = Strict::Float | Strict::Integer
  Frequency = Strict::String.enum("Weekly", "Monthly", "Annually")
  Type      = Strict::String.enum("GrossSalaryAmount", "Overtime")
end

module Frequency
  Weekly   = "Weekly"
  Monthly  = "Monthly"
  Annually = "Annually"
end

module Type
  GrossSalaryAmount = "GrossSalaryAmount"
  Overtime          = "Overtime"
end

class TopLevel < Dry::Struct
  attribute :amount,         Types::Double
  attribute :frequency,      Types::Frequency
  attribute :description,    Types::String.optional
  attribute :top_level_type, Types::Type

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      amount:         d.fetch("amount"),
      frequency:      d.fetch("frequency"),
      description:    d.key?("description") ? Types::String[d["description"]] : nil,
      top_level_type: d.fetch("type"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "amount"      => amount,
      "frequency"   => frequency,
      "description" => description,
      "type"        => top_level_type,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
