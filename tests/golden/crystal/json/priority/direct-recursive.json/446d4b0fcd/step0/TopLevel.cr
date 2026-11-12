require "json"

class TopLevel
  include JSON::Serializable

  property also : TopLevel?

  property bar : Bool

  property foo : Int64

  property moo : Float64

  property quux : String
end
