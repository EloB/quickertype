# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "[…]"
#   puts top_level.first.designation
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry.Types(default: :nominal)

  Hash       = Strict::Hash
  String     = Strict::String
  OrbitClass = Strict::String.enum("Apollo", "Amor", "Aten", "Comet", "Jupiter-family Comet", "Halley-type Comet*", "Parabolic Comet", "Jupiter-family Comet*", "Encke-type Comet")
  Pha        = Strict::String.enum("Y", "N", "n/a")
end

module OrbitClass
  Apollo                       = "Apollo"
  Amor                         = "Amor"
  Aten                         = "Aten"
  Comet                        = "Comet"
  JupiterFamilyComet           = "Jupiter-family Comet"
  HalleyTypeComet              = "Halley-type Comet*"
  ParabolicComet               = "Parabolic Comet"
  OrbitClassJupiterFamilyComet = "Jupiter-family Comet*"
  EnckeTypeComet               = "Encke-type Comet"
end

module Pha
  Y  = "Y"
  N  = "N"
  NA = "n/a"
end

class TopLevelElement < Dry::Struct
  attribute :designation,    Types::String
  attribute :discovery_date, Types::String.constrained(format: /\A\d{4}-\d\d-\d\dT\d\d:\d\d:\d\d(?:\.\d+)?(?:Z|[+-]\d\d:\d\d)\z/i)
  attribute :h_mag,          Types::String.optional
  attribute :i_deg,          Types::String
  attribute :moid_au,        Types::String
  attribute :orbit_class,    Types::OrbitClass
  attribute :period_yr,      Types::String.optional
  attribute :pha,            Types::Pha
  attribute :q_au_1,         Types::String
  attribute :q_au_2,         Types::String.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      designation:    d.fetch("designation"),
      discovery_date: d.fetch("discovery_date"),
      h_mag:          d.key?("h_mag") ? Types::String[d["h_mag"]] : nil,
      i_deg:          d.fetch("i_deg"),
      moid_au:        d.fetch("moid_au"),
      orbit_class:    d.fetch("orbit_class"),
      period_yr:      d.key?("period_yr") ? Types::String[d["period_yr"]] : nil,
      pha:            d.fetch("pha"),
      q_au_1:         d.fetch("q_au_1"),
      q_au_2:         d.key?("q_au_2") ? Types::String[d["q_au_2"]] : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "designation"    => designation,
      "discovery_date" => discovery_date,
      "h_mag"          => h_mag,
      "i_deg"          => i_deg,
      "moid_au"        => moid_au,
      "orbit_class"    => orbit_class,
      "period_yr"      => period_yr,
      "pha"            => pha,
      "q_au_1"         => q_au_1,
      "q_au_2"         => q_au_2,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel
  def self.from_json!(json)
    top_level = JSON.parse(json, quirks_mode: true).map { |x| TopLevelElement.from_dynamic!(x) }
    top_level.define_singleton_method(:to_json) do
      JSON.generate(self.map { |x| x.to_dynamic })
    end
    top_level
  end
end
