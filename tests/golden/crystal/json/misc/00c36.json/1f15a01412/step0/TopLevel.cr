require "json"

alias TopLevel = Array(TopLevelUnion)

class PurpleTopLevel
  include JSON::Serializable

  property country : Country

  property date : String

  property decimal : String

  property indicator : Country

  property value : String
end

class Country
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
