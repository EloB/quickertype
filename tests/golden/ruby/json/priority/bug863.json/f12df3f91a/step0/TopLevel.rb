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

  Integer   = Strict::Integer
  Hash      = Strict::Hash
  String    = Strict::String
  Double    = Strict::Float | Strict::Integer
  Breed     = Strict::String.enum("Atrox", "Solitus", "Opifex", "Nano")
  Firstname = Strict::String.enum("", "Chi")
  Lastname  = Strict::String.enum("", "Washko")
  Pvptitle  = Strict::String.enum("Freshman")
  RankTitle = Strict::String.enum("President", "Advisor", "Veteran", "Applicant")
  Sex       = Strict::String.enum("Neuter", "Male", "Female")
end

module Breed
  Atrox   = "Atrox"
  Solitus = "Solitus"
  Opifex  = "Opifex"
  Nano    = "Nano"
end

module Firstname
  Empty = ""
  Chi   = "Chi"
end

module Lastname
  Empty  = ""
  Washko = "Washko"
end

module Pvptitle
  Freshman = "Freshman"
end

module RankTitle
  President = "President"
  Advisor   = "Advisor"
  Veteran   = "Veteran"
  Applicant = "Applicant"
end

module Sex
  Neuter = "Neuter"
  Male   = "Male"
  Female = "Female"
end

class TopLevel1 < Dry::Struct
  attribute :alienlevel,          Types::Integer
  attribute :breed,               Types::Breed
  attribute :char_dimension,      Types::Integer
  attribute :char_instance,       Types::Integer
  attribute :defender_rank_title, Types::String
  attribute :firstname,           Types::Firstname
  attribute :headid,              Types::Integer
  attribute :lastname,            Types::Lastname
  attribute :levelx,              Types::Integer
  attribute :prof,                Types::String
  attribute :prof_title,          Types::String
  attribute :pvprating,           Types::Integer
  attribute :pvptitle,            Types::Pvptitle
  attribute :rank,                Types::Integer
  attribute :rank_title,          Types::RankTitle
  attribute :sex,                 Types::Sex
  attribute :top_level_name,      Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      alienlevel:          d.fetch("ALIENLEVEL"),
      breed:               d.fetch("BREED"),
      char_dimension:      d.fetch("CHAR_DIMENSION"),
      char_instance:       d.fetch("CHAR_INSTANCE"),
      defender_rank_title: d.fetch("DEFENDER_RANK_TITLE"),
      firstname:           d.fetch("FIRSTNAME"),
      headid:              d.fetch("HEADID"),
      lastname:            d.fetch("LASTNAME"),
      levelx:              d.fetch("LEVELX"),
      prof:                d.fetch("PROF"),
      prof_title:          d.fetch("PROF_TITLE"),
      pvprating:           d.fetch("PVPRATING"),
      pvptitle:            d.fetch("PVPTITLE"),
      rank:                d.fetch("RANK"),
      rank_title:          d.fetch("RANK_TITLE"),
      sex:                 d.fetch("SEX"),
      top_level_name:      d.fetch("NAME"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "ALIENLEVEL"          => alienlevel,
      "BREED"               => breed,
      "CHAR_DIMENSION"      => char_dimension,
      "CHAR_INSTANCE"       => char_instance,
      "DEFENDER_RANK_TITLE" => defender_rank_title,
      "FIRSTNAME"           => firstname,
      "HEADID"              => headid,
      "LASTNAME"            => lastname,
      "LEVELX"              => levelx,
      "PROF"                => prof,
      "PROF_TITLE"          => prof_title,
      "PVPRATING"           => pvprating,
      "PVPTITLE"            => pvptitle,
      "RANK"                => rank,
      "RANK_TITLE"          => rank_title,
      "SEX"                 => sex,
      "NAME"                => top_level_name,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel2 < Dry::Struct
  attribute :adventurercount, Types::Integer
  attribute :agentcount,      Types::Integer
  attribute :atroxcount,      Types::Integer
  attribute :avglvl,          Types::Double
  attribute :btcount,         Types::Integer
  attribute :description,     Types::String
  attribute :doctorcount,     Types::Integer
  attribute :enfcount,        Types::Integer
  attribute :engineeercount,  Types::Integer
  attribute :femalecount,     Types::Integer
  attribute :fixercount,      Types::Integer
  attribute :governingname,   Types::String
  attribute :history,         Types::String
  attribute :keepercount,     Types::Integer
  attribute :macount,         Types::Integer
  attribute :malecount,       Types::Integer
  attribute :maxlvl,          Types::Integer
  attribute :metacount,       Types::Integer
  attribute :minlvl,          Types::Integer
  attribute :monstercount,    Types::Integer
  attribute :nanocount,       Types::Integer
  attribute :nanoracecount,   Types::Integer
  attribute :neutercount,     Types::Integer
  attribute :nummembers,      Types::Integer
  attribute :objective,       Types::String
  attribute :opifexcount,     Types::Integer
  attribute :org_dimension,   Types::Integer
  attribute :org_instance,    Types::Integer
  attribute :shadecount,      Types::Integer
  attribute :side,            Types::Integer
  attribute :side_name,       Types::String
  attribute :solidercount,    Types::Integer
  attribute :solituscount,    Types::Integer
  attribute :top_level_name,  Types::String
  attribute :tradercount,     Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      adventurercount: d.fetch("ADVENTURERCOUNT"),
      agentcount:      d.fetch("AGENTCOUNT"),
      atroxcount:      d.fetch("ATROXCOUNT"),
      avglvl:          d.fetch("AVGLVL"),
      btcount:         d.fetch("BTCOUNT"),
      description:     d.fetch("DESCRIPTION"),
      doctorcount:     d.fetch("DOCTORCOUNT"),
      enfcount:        d.fetch("ENFCOUNT"),
      engineeercount:  d.fetch("ENGINEEERCOUNT"),
      femalecount:     d.fetch("FEMALECOUNT"),
      fixercount:      d.fetch("FIXERCOUNT"),
      governingname:   d.fetch("GOVERNINGNAME"),
      history:         d.fetch("HISTORY"),
      keepercount:     d.fetch("KEEPERCOUNT"),
      macount:         d.fetch("MACOUNT"),
      malecount:       d.fetch("MALECOUNT"),
      maxlvl:          d.fetch("MAXLVL"),
      metacount:       d.fetch("METACOUNT"),
      minlvl:          d.fetch("MINLVL"),
      monstercount:    d.fetch("MONSTERCOUNT"),
      nanocount:       d.fetch("NANOCOUNT"),
      nanoracecount:   d.fetch("NANORACECOUNT"),
      neutercount:     d.fetch("NEUTERCOUNT"),
      nummembers:      d.fetch("NUMMEMBERS"),
      objective:       d.fetch("OBJECTIVE"),
      opifexcount:     d.fetch("OPIFEXCOUNT"),
      org_dimension:   d.fetch("ORG_DIMENSION"),
      org_instance:    d.fetch("ORG_INSTANCE"),
      shadecount:      d.fetch("SHADECOUNT"),
      side:            d.fetch("SIDE"),
      side_name:       d.fetch("SIDE_NAME"),
      solidercount:    d.fetch("SOLIDERCOUNT"),
      solituscount:    d.fetch("SOLITUSCOUNT"),
      top_level_name:  d.fetch("NAME"),
      tradercount:     d.fetch("TRADERCOUNT"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "ADVENTURERCOUNT" => adventurercount,
      "AGENTCOUNT"      => agentcount,
      "ATROXCOUNT"      => atroxcount,
      "AVGLVL"          => avglvl,
      "BTCOUNT"         => btcount,
      "DESCRIPTION"     => description,
      "DOCTORCOUNT"     => doctorcount,
      "ENFCOUNT"        => enfcount,
      "ENGINEEERCOUNT"  => engineeercount,
      "FEMALECOUNT"     => femalecount,
      "FIXERCOUNT"      => fixercount,
      "GOVERNINGNAME"   => governingname,
      "HISTORY"         => history,
      "KEEPERCOUNT"     => keepercount,
      "MACOUNT"         => macount,
      "MALECOUNT"       => malecount,
      "MAXLVL"          => maxlvl,
      "METACOUNT"       => metacount,
      "MINLVL"          => minlvl,
      "MONSTERCOUNT"    => monstercount,
      "NANOCOUNT"       => nanocount,
      "NANORACECOUNT"   => nanoracecount,
      "NEUTERCOUNT"     => neutercount,
      "NUMMEMBERS"      => nummembers,
      "OBJECTIVE"       => objective,
      "OPIFEXCOUNT"     => opifexcount,
      "ORG_DIMENSION"   => org_dimension,
      "ORG_INSTANCE"    => org_instance,
      "SHADECOUNT"      => shadecount,
      "SIDE"            => side,
      "SIDE_NAME"       => side_name,
      "SOLIDERCOUNT"    => solidercount,
      "SOLITUSCOUNT"    => solituscount,
      "NAME"            => top_level_name,
      "TRADERCOUNT"     => tradercount,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevelUnion < Dry::Struct
  attribute :string,           Types::String.optional
  attribute :top_level1_array, Types.Array(TopLevel1).optional
  attribute :top_level2,       TopLevel2.optional

  def self.from_dynamic!(d)
    if schema.key(:string).type.right.valid? d
      return new(string: d, top_level1_array: nil, top_level2: nil)
    end
    begin
      value = d.map { |x| TopLevel1.from_dynamic!(x) }
      if schema.key(:top_level1_array).type.right.valid? value
        return new(top_level1_array: value, top_level2: nil, string: nil)
      end
    rescue
    end
    begin
      value = TopLevel2.from_dynamic!(d)
      if schema.key(:top_level2).type.right.valid? value
        return new(top_level2: value, top_level1_array: nil, string: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if string != nil
      string
    elsif top_level1_array != nil
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
