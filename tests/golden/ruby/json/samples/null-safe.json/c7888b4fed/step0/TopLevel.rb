# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.item.first.address&.city
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry.Types(default: :nominal)

  Integer = Strict::Integer
  Nil     = Strict::Nil
  Hash    = Strict::Hash
  String  = Strict::String
end

class Address < Dry::Struct
  attribute :city,    Types::String
  attribute :country, Types::String
  attribute :street,  Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      city:    d.fetch("city"),
      country: d.fetch("country"),
      street:  d.fetch("street"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "city"    => city,
      "country" => country,
      "street"  => street,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Item < Dry::Struct
  attribute :address,    Address.optional
  attribute :created_at, Types::String.constrained(format: /\A\d{4}-\d\d-\d\dT\d\d:\d\d:\d\d(?:\.\d+)?(?:Z|[+-]\d\d:\d\d)\z/i).optional
  attribute :item_name,  Types::String
  attribute :sex,        Types::Integer.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      address:    d.key?("address") ? Address.from_dynamic!(d["address"]) : nil,
      created_at: d.key?("created_at") ? Types::String.constrained(format: /\A\d{4}-\d\d-\d\dT\d\d:\d\d:\d\d(?:\.\d+)?(?:Z|[+-]\d\d:\d\d)\z/i)[d["created_at"]] : nil,
      item_name:  d.fetch("name"),
      sex:        d.fetch("sex"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "address"    => address&.to_dynamic,
      "created_at" => created_at,
      "name"       => item_name,
      "sex"        => sex,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel < Dry::Struct
  attribute :item, Types.Array(Item)

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      item: d.fetch("item").map { |x| Item.from_dynamic!(x) },
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "item" => item.map { |x| x.to_dynamic },
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
