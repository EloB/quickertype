require "json"

alias TopLevel = Hash(String, TopLevelValue)

class TopLevelValue
  include JSON::Serializable

  property channel_id : String

  property channel_name : String

  property code : String

  property emoticon_set : Int64

  property id : Int64
end
