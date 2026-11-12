require "json"

class TopLevel
  include JSON::Serializable

  property prizes : Array(Prize)
end

class Prize
  include JSON::Serializable

  property category : String

  property laureates : Array(Laureate)

  @[JSON::Field(key: "overallMotivation")]
  property overall_motivation : String?

  property year : String
end

class Laureate
  include JSON::Serializable

  property firstname : String

  property id : String

  property motivation : String?

  property share : String

  property surname : String
end
