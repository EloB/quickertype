require "json"

alias TopLevel = Array(TopLevelUnion)

class PurpleTopLevel
  include JSON::Serializable

  @[JSON::Field(key: "ALIENLEVEL")]
  property alienlevel : Int64

  @[JSON::Field(key: "BREED")]
  property breed : String

  @[JSON::Field(key: "CHAR_DIMENSION")]
  property char_dimension : Int64

  @[JSON::Field(key: "CHAR_INSTANCE")]
  property char_instance : Int64

  @[JSON::Field(key: "DEFENDER_RANK_TITLE")]
  property defender_rank_title : String

  @[JSON::Field(key: "FIRSTNAME")]
  property firstname : String

  @[JSON::Field(key: "HEADID")]
  property headid : Int64

  @[JSON::Field(key: "LASTNAME")]
  property lastname : String

  @[JSON::Field(key: "LEVELX")]
  property levelx : Int64

  @[JSON::Field(key: "NAME")]
  property name : String

  @[JSON::Field(key: "PROF")]
  property prof : String

  @[JSON::Field(key: "PROF_TITLE")]
  property prof_title : String

  @[JSON::Field(key: "PVPRATING")]
  property pvprating : Int64

  @[JSON::Field(key: "PVPTITLE")]
  property pvptitle : String

  @[JSON::Field(key: "RANK")]
  property rank : Int64

  @[JSON::Field(key: "RANK_TITLE")]
  property rank_title : String

  @[JSON::Field(key: "SEX")]
  property sex : String
end

class FluffyTopLevel
  include JSON::Serializable

  @[JSON::Field(key: "ADVENTURERCOUNT")]
  property adventurercount : Int64

  @[JSON::Field(key: "AGENTCOUNT")]
  property agentcount : Int64

  @[JSON::Field(key: "ATROXCOUNT")]
  property atroxcount : Int64

  @[JSON::Field(key: "AVGLVL")]
  property avglvl : Float64

  @[JSON::Field(key: "BTCOUNT")]
  property btcount : Int64

  @[JSON::Field(key: "DESCRIPTION")]
  property description : String

  @[JSON::Field(key: "DOCTORCOUNT")]
  property doctorcount : Int64

  @[JSON::Field(key: "ENFCOUNT")]
  property enfcount : Int64

  @[JSON::Field(key: "ENGINEEERCOUNT")]
  property engineeercount : Int64

  @[JSON::Field(key: "FEMALECOUNT")]
  property femalecount : Int64

  @[JSON::Field(key: "FIXERCOUNT")]
  property fixercount : Int64

  @[JSON::Field(key: "GOVERNINGNAME")]
  property governingname : String

  @[JSON::Field(key: "HISTORY")]
  property history : String

  @[JSON::Field(key: "KEEPERCOUNT")]
  property keepercount : Int64

  @[JSON::Field(key: "MACOUNT")]
  property macount : Int64

  @[JSON::Field(key: "MALECOUNT")]
  property malecount : Int64

  @[JSON::Field(key: "MAXLVL")]
  property maxlvl : Int64

  @[JSON::Field(key: "METACOUNT")]
  property metacount : Int64

  @[JSON::Field(key: "MINLVL")]
  property minlvl : Int64

  @[JSON::Field(key: "MONSTERCOUNT")]
  property monstercount : Int64

  @[JSON::Field(key: "NAME")]
  property name : String

  @[JSON::Field(key: "NANOCOUNT")]
  property nanocount : Int64

  @[JSON::Field(key: "NANORACECOUNT")]
  property nanoracecount : Int64

  @[JSON::Field(key: "NEUTERCOUNT")]
  property neutercount : Int64

  @[JSON::Field(key: "NUMMEMBERS")]
  property nummembers : Int64

  @[JSON::Field(key: "OBJECTIVE")]
  property objective : String

  @[JSON::Field(key: "OPIFEXCOUNT")]
  property opifexcount : Int64

  @[JSON::Field(key: "ORG_DIMENSION")]
  property org_dimension : Int64

  @[JSON::Field(key: "ORG_INSTANCE")]
  property org_instance : Int64

  @[JSON::Field(key: "SHADECOUNT")]
  property shadecount : Int64

  @[JSON::Field(key: "SIDE")]
  property side : Int64

  @[JSON::Field(key: "SIDE_NAME")]
  property side_name : String

  @[JSON::Field(key: "SOLIDERCOUNT")]
  property solidercount : Int64

  @[JSON::Field(key: "SOLITUSCOUNT")]
  property solituscount : Int64

  @[JSON::Field(key: "TRADERCOUNT")]
  property tradercount : Int64
end

alias TopLevelUnion = FluffyTopLevel | String | Array(PurpleTopLevel)
