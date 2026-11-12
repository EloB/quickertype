require "json"

class TopLevel
  include JSON::Serializable

  property laureates : Array(Laureate)
end

class Laureate
  include JSON::Serializable

  property born : String

  @[JSON::Field(key: "bornCity")]
  property born_city : String?

  @[JSON::Field(key: "bornCountry")]
  property born_country : String?

  @[JSON::Field(key: "bornCountryCode")]
  property born_country_code : String?

  property died : String

  @[JSON::Field(key: "diedCity")]
  property died_city : String?

  @[JSON::Field(key: "diedCountry")]
  property died_country : String?

  @[JSON::Field(key: "diedCountryCode")]
  property died_country_code : String?

  property firstname : String?

  property gender : String

  property id : String

  property prizes : Array(Prize)

  property surname : String?
end

class Prize
  include JSON::Serializable

  property affiliations : Array(AffiliationElement)

  property category : String?

  property motivation : String?

  @[JSON::Field(key: "overallMotivation")]
  property overall_motivation : String?

  property share : String?

  property year : String?
end

class AffiliationClass
  include JSON::Serializable

  property city : String?

  property country : String?

  property name : String?
end

alias AffiliationElement = AffiliationClass | Array(JSON::Any?)
