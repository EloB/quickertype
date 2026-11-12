require "json"

class TopLevel
  include JSON::Serializable

  property query : Query
end

class Query
  include JSON::Serializable

  property count : Int64

  property created : String

  property lang : String

  property results : Results
end

class Results
  include JSON::Serializable

  property channel : ChannelClass
end

class ChannelClass
  include JSON::Serializable

  property astronomy : Astronomy

  property atmosphere : Atmosphere

  property description : String

  property image : Image

  property item : Item

  property language : String

  @[JSON::Field(key: "lastBuildDate")]
  property last_build_date : String

  property link : String

  property location : Location

  property title : String

  property ttl : String

  property units : Units

  property wind : Wind
end

class Astronomy
  include JSON::Serializable

  property sunrise : String

  property sunset : String
end

class Atmosphere
  include JSON::Serializable

  property humidity : String

  property pressure : String

  property rising : String

  property visibility : String
end

class Image
  include JSON::Serializable

  property height : String

  property link : String

  property title : String

  property url : String

  property width : String
end

class Item
  include JSON::Serializable

  property condition : Condition

  property description : String

  property forecast : Array(Forecast)

  property guid : Guid

  property lat : String

  property link : String

  property long : String

  @[JSON::Field(key: "pubDate")]
  property pub_date : String

  property title : String
end

class Condition
  include JSON::Serializable

  property code : String

  property date : String

  property temp : String

  property text : String
end

class Forecast
  include JSON::Serializable

  property code : String

  property date : String

  property day : String

  property high : String

  property low : String

  property text : String
end

class Guid
  include JSON::Serializable

  @[JSON::Field(key: "isPermaLink")]
  property is_perma_link : String
end

class Location
  include JSON::Serializable

  property city : String

  property country : String

  property region : String
end

class Units
  include JSON::Serializable

  property distance : String

  property pressure : String

  property speed : String

  property temperature : String
end

class Wind
  include JSON::Serializable

  property chill : String

  property direction : String

  property speed : String
end
