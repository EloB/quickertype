# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.prizes.first.laureates.first.firstname
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry.Types(default: :nominal)

  Hash     = Strict::Hash
  String   = Strict::String
  Category = Strict::String.enum("physics", "chemistry", "medicine", "literature", "peace", "economics")
end

module Category
  Physics    = "physics"
  Chemistry  = "chemistry"
  Medicine   = "medicine"
  Literature = "literature"
  Peace      = "peace"
  Economics  = "economics"
end

class Laureate < Dry::Struct
  attribute :firstname,  Types::String
  attribute :id,         Types::String
  attribute :motivation, Types::String.optional
  attribute :share,      Types::String
  attribute :surname,    Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      firstname:  d.fetch("firstname"),
      id:         d.fetch("id"),
      motivation: d.key?("motivation") ? Types::String[d["motivation"]] : nil,
      share:      d.fetch("share"),
      surname:    d.fetch("surname"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "firstname"  => firstname,
      "id"         => id,
      "motivation" => motivation,
      "share"      => share,
      "surname"    => surname,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Prize < Dry::Struct
  attribute :category,           Types::Category
  attribute :laureates,          Types.Array(Laureate)
  attribute :overall_motivation, Types::String.optional
  attribute :year,               Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      category:           d.fetch("category"),
      laureates:          d.fetch("laureates").map { |x| Laureate.from_dynamic!(x) },
      overall_motivation: d.key?("overallMotivation") ? Types::String[d["overallMotivation"]] : nil,
      year:               d.fetch("year"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "category"          => category,
      "laureates"         => laureates.map { |x| x.to_dynamic },
      "overallMotivation" => overall_motivation,
      "year"              => year,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel < Dry::Struct
  attribute :prizes, Types.Array(Prize)

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      prizes: d.fetch("prizes").map { |x| Prize.from_dynamic!(x) },
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "prizes" => prizes.map { |x| x.to_dynamic },
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
