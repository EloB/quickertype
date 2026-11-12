require "json"

class TopLevel
  include JSON::Serializable

  property group : String

  property movie : String

  @[JSON::Field(key: "movie-image")]
  property movie_image : String

  property theater : String
end
