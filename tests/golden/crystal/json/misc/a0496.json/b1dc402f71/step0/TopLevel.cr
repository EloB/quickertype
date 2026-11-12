require "json"

class TopLevel
  include JSON::Serializable

  property code : String

  property column_names : Array(String)

  property data : Array(Array(Datum?))

  property description : String

  property display_url : String

  property errors : Errors

  property frequency : String

  property from_date : String

  property id : Int64

  property name : String

  property premium : Bool

  property source_code : String

  property source_name : String

  property to_date : String

  @[JSON::Field(key: "type")]
  property top_level_type : String

  property updated_at : String

  property urlize_name : String
end

class Errors
  include JSON::Serializable

end

alias Datum = Float64 | String
