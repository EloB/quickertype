require "json"

class TopLevel
  include JSON::Serializable

  property count : Int64

  property previous : Nil

  property results : Array(Result)

  @[JSON::Field(key: "next")]
  property top_level_next : String
end

class Result
  include JSON::Serializable

  property code : String

  property english : String

  property fav : Bool

  property group : Group

  property location : String

  property min_screens : Int64

  property num_views : Int64

  property showtimes : String

  property stars : Int64

  property tel : String

  property thai : String

  property today_screens : Int64

  property url : String

  property website : String
end

class Group
  include JSON::Serializable

  property code : String

  property english : String

  property thai : String

  property website : String
end
