require "json"

alias TopLevel = Array(TopLevelElement)

class TopLevelElement
  include JSON::Serializable

  @[JSON::Field(key: "BirthDate")]
  property birth_date : String?

  @[JSON::Field(key: "BirthDateIsProtected")]
  property birth_date_is_protected : Bool

  @[JSON::Field(key: "GenderTypeID")]
  property gender_type_id : Int64

  @[JSON::Field(key: "Notes")]
  property notes : String

  @[JSON::Field(key: "ParliamentaryName")]
  property parliamentary_name : String

  @[JSON::Field(key: "PersonID")]
  property person_id : Int64

  @[JSON::Field(key: "PhotoURL")]
  property photo_url : String

  @[JSON::Field(key: "PreferredName")]
  property preferred_name : String
end
