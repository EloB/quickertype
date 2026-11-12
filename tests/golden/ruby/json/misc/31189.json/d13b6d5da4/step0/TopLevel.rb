# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.rates.first.periods.first.rates.parking
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry.Types(default: :nominal)

  Nil    = Strict::Nil
  Hash   = Strict::Hash
  String = Strict::String
  Double = Strict::Float | Strict::Integer
end

class Rates < Dry::Struct
  attribute :parking,       Types::Double.optional
  attribute :reduced,       Types::Double.optional
  attribute :reduced1,      Types::Double.optional
  attribute :reduced2,      Types::Double.optional
  attribute :standard,      Types::Double
  attribute :super_reduced, Types::Double.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      parking:       d.key?("parking") ? Types::Double[d["parking"]] : nil,
      reduced:       d.key?("reduced") ? Types::Double[d["reduced"]] : nil,
      reduced1:      d.key?("reduced1") ? Types::Double[d["reduced1"]] : nil,
      reduced2:      d.key?("reduced2") ? Types::Double[d["reduced2"]] : nil,
      standard:      d.fetch("standard"),
      super_reduced: d.key?("super_reduced") ? Types::Double[d["super_reduced"]] : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "parking"       => parking,
      "reduced"       => reduced,
      "reduced1"      => reduced1,
      "reduced2"      => reduced2,
      "standard"      => standard,
      "super_reduced" => super_reduced,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Period < Dry::Struct
  attribute :effective_from, Types::String
  attribute :rates,          Rates

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      effective_from: d.fetch("effective_from"),
      rates:          Rates.from_dynamic!(d.fetch("rates")),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "effective_from" => effective_from,
      "rates"          => rates.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Rate < Dry::Struct
  attribute :code,         Types::String
  attribute :country_code, Types::String
  attribute :periods,      Types.Array(Period)
  attribute :rate_name,    Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      code:         d.fetch("code"),
      country_code: d.fetch("country_code"),
      periods:      d.fetch("periods").map { |x| Period.from_dynamic!(x) },
      rate_name:    d.fetch("name"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "code"         => code,
      "country_code" => country_code,
      "periods"      => periods.map { |x| x.to_dynamic },
      "name"         => rate_name,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel < Dry::Struct
  attribute :details, Types::String
  attribute :rates,   Types.Array(Rate)
  attribute :version, Types::Nil

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      details: d.fetch("details"),
      rates:   d.fetch("rates").map { |x| Rate.from_dynamic!(x) },
      version: d.fetch("version"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "details" => details,
      "rates"   => rates.map { |x| x.to_dynamic },
      "version" => version,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
