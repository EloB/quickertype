require "json"

class TopLevel
  include JSON::Serializable

  property bar : Int64

  property foo : Int64

  property quux : Bool
end
