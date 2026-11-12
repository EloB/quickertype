require "json"

class TopLevel
  include JSON::Serializable

  property literal : String

  @[JSON::Field(key: "\u{0023}{1+1}")]
  property the_11 : Int64

  property values : Array(String)
end
