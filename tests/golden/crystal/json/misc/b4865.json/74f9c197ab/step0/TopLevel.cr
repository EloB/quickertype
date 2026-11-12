require "json"

alias TopLevel = Array(TopLevelElement)

class TopLevelElement
  include JSON::Serializable

  @[JSON::Field(key: ":@computed_region_cbhk_fwbd")]
  property computed_region_cbhk_fwbd : String?

  @[JSON::Field(key: ":@computed_region_nnqa_25f4")]
  property computed_region_nnqa_25_f4 : String?

  property fall : String

  property geolocation : Geolocation?

  property id : String

  property mass : String?

  property name : String

  property nametype : String

  property recclass : String

  property reclat : String?

  property reclong : String?

  property year : String?
end

class Geolocation
  include JSON::Serializable

  property coordinates : Array(Float64)

  @[JSON::Field(key: "type")]
  property geolocation_type : String
end
