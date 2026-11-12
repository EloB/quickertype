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
  ID      = Strict::String.enum("", "SAS", "SSA", "ECA", "LAC", "EAP", "MNA", "HIC", "LIC", "NA", "LMC", "UMC", "LNX", "IDX", "IBD", "IDB", "LCN", "SSF", "ECS", "MEA", "EAS", "NAC")
  Value   = Strict::String.enum("", "South Asia", "Sub-Saharan Africa (excluding high income)", "Europe & Central Asia (excluding high income)", "Latin America & Caribbean (excluding high income)", "East Asia & Pacific (excluding high income)", "Middle East & North Africa (excluding high income)", "High income", "Low income", "Aggregates", "Lower middle income", "Upper middle income", "Not classified", "IDA", "IBRD", "Blend", "Latin America & Caribbean ", "Sub-Saharan Africa ", "Europe & Central Asia", "Middle East & North Africa", "East Asia & Pacific", "North America")
end

module ID
  Empty = ""
  SAS   = "SAS"
  SSA   = "SSA"
  Eca   = "ECA"
  Lac   = "LAC"
  EAP   = "EAP"
  Mna   = "MNA"
  Hic   = "HIC"
  Lic   = "LIC"
  Na    = "NA"
  Lmc   = "LMC"
  Umc   = "UMC"
  Lnx   = "LNX"
  Idx   = "IDX"
  Ibd   = "IBD"
  Idb   = "IDB"
  Lcn   = "LCN"
  Ssf   = "SSF"
  Ecs   = "ECS"
  Mea   = "MEA"
  EAS   = "EAS"
  Nac   = "NAC"
end

module Value
  Empty                                    = ""
  SouthAsia                                = "South Asia"
  SubSaharanAfricaExcludingHighIncome      = "Sub-Saharan Africa (excluding high income)"
  EuropeCentralAsiaExcludingHighIncome     = "Europe & Central Asia (excluding high income)"
  LatinAmericaCaribbeanExcludingHighIncome = "Latin America & Caribbean (excluding high income)"
  EastAsiaPacificExcludingHighIncome       = "East Asia & Pacific (excluding high income)"
  MiddleEastNorthAfricaExcludingHighIncome = "Middle East & North Africa (excluding high income)"
  HighIncome                               = "High income"
  LowIncome                                = "Low income"
  Aggregates                               = "Aggregates"
  LowerMiddleIncome                        = "Lower middle income"
  UpperMiddleIncome                        = "Upper middle income"
  NotClassified                            = "Not classified"
  Ida                                      = "IDA"
  Ibrd                                     = "IBRD"
  Blend                                    = "Blend"
  LatinAmericaCaribbean                    = "Latin America & Caribbean "
  SubSaharanAfrica                         = "Sub-Saharan Africa "
  EuropeCentralAsia                        = "Europe & Central Asia"
  MiddleEastNorthAfrica                    = "Middle East & North Africa"
  EastAsiaPacific                          = "East Asia & Pacific"
  NorthAmerica                             = "North America"
end

class Adminregion < Dry::Struct
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
  attribute :adminregion,    Adminregion
  attribute :capital_city,   Types::String
  attribute :id,             Types::String
  attribute :income_level,   Adminregion
  attribute :iso2_code,      Types::String
  attribute :latitude,       Types::String
  attribute :lending_type,   Adminregion
  attribute :longitude,      Types::String
  attribute :region,         Adminregion
  attribute :top_level_name, Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      adminregion:    Adminregion.from_dynamic!(d.fetch("adminregion")),
      capital_city:   d.fetch("capitalCity"),
      id:             d.fetch("id"),
      income_level:   Adminregion.from_dynamic!(d.fetch("incomeLevel")),
      iso2_code:      d.fetch("iso2Code"),
      latitude:       d.fetch("latitude"),
      lending_type:   Adminregion.from_dynamic!(d.fetch("lendingType")),
      longitude:      d.fetch("longitude"),
      region:         Adminregion.from_dynamic!(d.fetch("region")),
      top_level_name: d.fetch("name"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "adminregion" => adminregion.to_dynamic,
      "capitalCity" => capital_city,
      "id"          => id,
      "incomeLevel" => income_level.to_dynamic,
      "iso2Code"    => iso2_code,
      "latitude"    => latitude,
      "lendingType" => lending_type.to_dynamic,
      "longitude"   => longitude,
      "region"      => region.to_dynamic,
      "name"        => top_level_name,
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
