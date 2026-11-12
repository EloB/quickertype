require "json"

class TopLevel
  include JSON::Serializable

  property date : Int64

  property title : String

  property validity : Bool
end
