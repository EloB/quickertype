require "json"

class TopLevel
  include JSON::Serializable

  property count : Int64

  property facets : Facets

  property limit : Int64

  property offset : Int64

  property previous : Bool

  property results : Array(Result)

  @[JSON::Field(key: "next")]
  property top_level_next : String
end

class Facets
  include JSON::Serializable

end

class Result
  include JSON::Serializable

  property created_at : String

  property entity : String

  property first_name : String

  property id : String

  property last_name : String

  property name : String

  property position : String?

  property status : String

  property title : String?

  property updated_at : String

  property uri : String
end
