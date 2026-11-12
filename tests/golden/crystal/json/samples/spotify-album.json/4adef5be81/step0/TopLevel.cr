require "json"

class TopLevel
  include JSON::Serializable

  property album_type : String

  property artists : Array(Artist)

  property available_markets : Array(String)

  property copyrights : Array(Copyright)

  property external_ids : ExternalIds

  property external_urls : ExternalUrls

  property genres : Array(JSON::Any?)

  property href : String

  property id : String

  property images : Array(Image)

  property name : String

  property popularity : Int64

  property release_date : String

  property release_date_precision : String

  @[JSON::Field(key: "type")]
  property top_level_type : String

  property tracks : Tracks

  property uri : String
end

class Artist
  include JSON::Serializable

  @[JSON::Field(key: "type")]
  property artist_type : String

  property external_urls : ExternalUrls

  property href : String

  property id : String

  property name : String

  property uri : String
end

class ExternalUrls
  include JSON::Serializable

  property spotify : String
end

class Copyright
  include JSON::Serializable

  @[JSON::Field(key: "type")]
  property copyright_type : String

  property text : String
end

class ExternalIds
  include JSON::Serializable

  property upc : String
end

class Image
  include JSON::Serializable

  property height : Int64

  property url : String

  property width : Int64
end

class Tracks
  include JSON::Serializable

  property href : String

  property items : Array(Item)

  property limit : Int64

  property offset : Int64

  property previous : Nil

  property total : Int64

  @[JSON::Field(key: "next")]
  property tracks_next : Nil
end

class Item
  include JSON::Serializable

  property artists : Array(Artist)

  property available_markets : Array(String)

  property disc_number : Int64

  property duration_ms : Int64

  property explicit : Bool

  property external_urls : ExternalUrls

  property href : String

  property id : String

  @[JSON::Field(key: "type")]
  property item_type : String

  property name : String

  property preview_url : String

  property track_number : Int64

  property uri : String
end
