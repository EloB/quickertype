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

  property active_screens : Int64

  property collections : Array(Collection)

  property details : Array(Detail)

  property duration : Int64

  property fav_movie : FavMovie

  property id : Int64

  property images : Array(Image)

  property language : String

  property release_date : String

  property stars : Int64

  property tags : Array(JSON::Any?)?

  property title : String

  property videos : Array(Video)

  property vote_score : VoteScore

  property watches : Int64
end

class Collection
  include JSON::Serializable

  property id : Int64

  property movies : Array(Int64)

  property name : String

  property slug : String
end

class Detail
  include JSON::Serializable

  property cast : String

  property director : String

  property id : Int64

  property language : String

  property storyline : String

  property tagline : String

  property title : String
end

class FavMovie
  include JSON::Serializable

  property follow : Bool

  property star : Bool

  property watched : Bool
end

class Image
  include JSON::Serializable

  property favs : Int64

  property id : Int64

  @[JSON::Field(key: "type")]
  property image_type : String

  property thumbnail : String

  property url : String
end

class Video
  include JSON::Serializable

  property kind : String

  property language : String

  property source : String

  property url : String
end

class VoteScore
  include JSON::Serializable

  property avg : Int64

  property score : Int64

  property total : Int64
end
