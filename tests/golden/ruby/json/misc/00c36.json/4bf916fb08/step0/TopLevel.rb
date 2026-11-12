# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "[…]"
#   puts top_level.first
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry.Types(default: :nominal)

  Integer = Strict::Integer
  Hash    = Strict::Hash
  String  = Strict::String
  ID      = Strict::String.enum("US", "NY.GDP.MKTP.CD")
  Value   = Strict::String.enum("United States", "GDP (current US$)")
end

module ID
  Us          = "US"
  NyGdpMktpCD = "NY.GDP.MKTP.CD"
end

module Value
  UnitedStates = "United States"
  GDPCurrentUS = "GDP (current US$)"
end

class Country < Dry::Struct
  attribute :id,    Types::ID
  attribute :value, Types::Value

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      id:    d.fetch("id"),
      value: d.fetch("value"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "id"    => id,
      "value" => value,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel1 < Dry::Struct
  attribute :country,   Country
  attribute :date,      Types::String
  attribute :decimal,   Types::String
  attribute :indicator, Country
  attribute :value,     Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      country:   Country.from_dynamic!(d.fetch("country")),
      date:      d.fetch("date"),
      decimal:   d.fetch("decimal"),
      indicator: Country.from_dynamic!(d.fetch("indicator")),
      value:     d.fetch("value"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "country"   => country.to_dynamic,
      "date"      => date,
      "decimal"   => decimal,
      "indicator" => indicator.to_dynamic,
      "value"     => value,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel2 < Dry::Struct
  attribute :page,     Types::Integer
  attribute :pages,    Types::Integer
  attribute :per_page, Types::String
  attribute :total,    Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      page:     d.fetch("page"),
      pages:    d.fetch("pages"),
      per_page: d.fetch("per_page"),
      total:    d.fetch("total"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "page"     => page,
      "pages"    => pages,
      "per_page" => per_page,
      "total"    => total,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevelUnion < Dry::Struct
  attribute :top_level1_array, Types.Array(TopLevel1).optional
  attribute :top_level2,       TopLevel2.optional

  def self.from_dynamic!(d)
    begin
      value = d.map { |x| TopLevel1.from_dynamic!(x) }
      if schema.key(:top_level1_array).type.right.valid? value
        return new(top_level1_array: value, top_level2: nil)
      end
    rescue
    end
    begin
      value = TopLevel2.from_dynamic!(d)
      if schema.key(:top_level2).type.right.valid? value
        return new(top_level2: value, top_level1_array: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if top_level1_array != nil
      top_level1_array.map { |x| x.to_dynamic }
    elsif top_level2 != nil
      top_level2.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel
  def self.from_json!(json)
    top_level = JSON.parse(json, quirks_mode: true).map { |x| TopLevelUnion.from_dynamic!(x) }
    top_level.define_singleton_method(:to_json) do
      JSON.generate(self.map { |x| x.to_dynamic })
    end
    top_level
  end
end
