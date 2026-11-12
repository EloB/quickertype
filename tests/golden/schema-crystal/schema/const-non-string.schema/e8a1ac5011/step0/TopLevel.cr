require "json"

class TopLevel
  include JSON::Serializable

  property amount : Int64

  property enabled : Bool

  property kind : String

  property ratio : Float64

  property version : Float64
end
