require "json"

alias TopLevel = Array(TopLevelUnion)

class PurpleTopLevel
  include JSON::Serializable

  property adminregion : Adminregion

  @[JSON::Field(key: "capitalCity")]
  property capital_city : String

  property id : String

  @[JSON::Field(key: "incomeLevel")]
  property income_level : Adminregion

  @[JSON::Field(key: "iso2Code")]
  property iso2_code : String

  property latitude : String

  @[JSON::Field(key: "lendingType")]
  property lending_type : Adminregion

  property longitude : String

  property name : String

  property region : Adminregion
end

class Adminregion
  include JSON::Serializable

  property id : String

  property value : String
end

class FluffyTopLevel
  include JSON::Serializable

  property page : Int64

  property pages : Int64

  property per_page : String

  property total : Int64
end

alias TopLevelUnion = FluffyTopLevel | Array(PurpleTopLevel)
