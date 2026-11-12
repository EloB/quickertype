# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.laureates.first.prizes.first.affiliations.first
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry.Types(default: :nominal)

  Hash     = Strict::Hash
  String   = Strict::String
  Gender   = Strict::String.enum("male", "female", "org")
  Category = Strict::String.enum("physics", "chemistry", "peace", "medicine", "literature", "economics")
end

module Gender
  Male   = "male"
  Female = "female"
  Org    = "org"
end

class AffiliationClass < Dry::Struct
  attribute :affiliation_name, Types::String.optional
  attribute :city,             Types::String.optional
  attribute :country,          Types::String.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      affiliation_name: d.key?("name") ? Types::String[d["name"]] : nil,
      city:             d.key?("city") ? Types::String[d["city"]] : nil,
      country:          d.key?("country") ? Types::String[d["country"]] : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "name"    => affiliation_name,
      "city"    => city,
      "country" => country,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class AffiliationElement < Dry::Struct
  attribute :affiliation_class, AffiliationClass.optional
  attribute :anything_array,    Types.Array(Types::Any).optional

  def self.from_dynamic!(d)
    begin
      value = AffiliationClass.from_dynamic!(d)
      if schema.key(:affiliation_class).type.right.valid? value
        return new(affiliation_class: value, anything_array: nil)
      end
    rescue
    end
    if schema.key(:anything_array).type.right.valid? d
      return new(anything_array: d, affiliation_class: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if affiliation_class != nil
      affiliation_class.to_dynamic
    elsif anything_array != nil
      anything_array
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

module Category
  Physics    = "physics"
  Chemistry  = "chemistry"
  Peace      = "peace"
  Medicine   = "medicine"
  Literature = "literature"
  Economics  = "economics"
end

class Prize < Dry::Struct
  attribute :affiliations,       Types.Array(Types.Instance(AffiliationElement))
  attribute :category,           Types::Category.optional
  attribute :motivation,         Types::String.optional
  attribute :overall_motivation, Types::String.optional
  attribute :share,              Types::String.optional
  attribute :year,               Types::String.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      affiliations:       d.fetch("affiliations").map { |x| AffiliationElement.from_dynamic!(x) },
      category:           d.key?("category") ? Types::Category[d["category"]] : nil,
      motivation:         d.key?("motivation") ? Types::String[d["motivation"]] : nil,
      overall_motivation: d.key?("overallMotivation") ? Types::String[d["overallMotivation"]] : nil,
      share:              d.key?("share") ? Types::String[d["share"]] : nil,
      year:               d.key?("year") ? Types::String[d["year"]] : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "affiliations"      => affiliations.map { |x| x.to_dynamic },
      "category"          => category,
      "motivation"        => motivation,
      "overallMotivation" => overall_motivation,
      "share"             => share,
      "year"              => year,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Laureate < Dry::Struct
  attribute :born,              Types::String
  attribute :born_city,         Types::String.optional
  attribute :born_country,      Types::String.optional
  attribute :born_country_code, Types::String.optional
  attribute :died,              Types::String
  attribute :died_city,         Types::String.optional
  attribute :died_country,      Types::String.optional
  attribute :died_country_code, Types::String.optional
  attribute :firstname,         Types::String.optional
  attribute :gender,            Types::Gender
  attribute :id,                Types::String
  attribute :prizes,            Types.Array(Prize)
  attribute :surname,           Types::String.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      born:              d.fetch("born"),
      born_city:         d.key?("bornCity") ? Types::String[d["bornCity"]] : nil,
      born_country:      d.key?("bornCountry") ? Types::String[d["bornCountry"]] : nil,
      born_country_code: d.key?("bornCountryCode") ? Types::String[d["bornCountryCode"]] : nil,
      died:              d.fetch("died"),
      died_city:         d.key?("diedCity") ? Types::String[d["diedCity"]] : nil,
      died_country:      d.key?("diedCountry") ? Types::String[d["diedCountry"]] : nil,
      died_country_code: d.key?("diedCountryCode") ? Types::String[d["diedCountryCode"]] : nil,
      firstname:         d.key?("firstname") ? Types::String[d["firstname"]] : nil,
      gender:            d.fetch("gender"),
      id:                d.fetch("id"),
      prizes:            d.fetch("prizes").map { |x| Prize.from_dynamic!(x) },
      surname:           d.key?("surname") ? Types::String[d["surname"]] : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "born"            => born,
      "bornCity"        => born_city,
      "bornCountry"     => born_country,
      "bornCountryCode" => born_country_code,
      "died"            => died,
      "diedCity"        => died_city,
      "diedCountry"     => died_country,
      "diedCountryCode" => died_country_code,
      "firstname"       => firstname,
      "gender"          => gender,
      "id"              => id,
      "prizes"          => prizes.map { |x| x.to_dynamic },
      "surname"         => surname,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel < Dry::Struct
  attribute :laureates, Types.Array(Laureate)

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      laureates: d.fetch("laureates").map { |x| Laureate.from_dynamic!(x) },
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "laureates" => laureates.map { |x| x.to_dynamic },
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
