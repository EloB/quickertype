# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "[…]"
#   puts top_level.first.birth_date.nil?
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry.Types(default: :nominal)

  Integer = Strict::Integer
  Nil     = Strict::Nil
  Bool    = Strict::Bool
  Hash    = Strict::Hash
  String  = Strict::String
end

class TopLevelElement < Dry::Struct
  attribute :birth_date,              Types::String.constrained(format: /\A\d{4}-\d\d-\d\dT\d\d:\d\d:\d\d(?:\.\d+)?(?:Z|[+-]\d\d:\d\d)\z/i).optional
  attribute :birth_date_is_protected, Types::Bool
  attribute :gender_type_id,          Types::Integer
  attribute :notes,                   Types::String
  attribute :parliamentary_name,      Types::String
  attribute :person_id,               Types::Integer
  attribute :photo_url,               Types::String
  attribute :preferred_name,          Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      birth_date:              d.fetch("BirthDate"),
      birth_date_is_protected: d.fetch("BirthDateIsProtected"),
      gender_type_id:          d.fetch("GenderTypeID"),
      notes:                   d.fetch("Notes"),
      parliamentary_name:      d.fetch("ParliamentaryName"),
      person_id:               d.fetch("PersonID"),
      photo_url:               d.fetch("PhotoURL"),
      preferred_name:          d.fetch("PreferredName"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "BirthDate"            => birth_date,
      "BirthDateIsProtected" => birth_date_is_protected,
      "GenderTypeID"         => gender_type_id,
      "Notes"                => notes,
      "ParliamentaryName"    => parliamentary_name,
      "PersonID"             => person_id,
      "PhotoURL"             => photo_url,
      "PreferredName"        => preferred_name,
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
