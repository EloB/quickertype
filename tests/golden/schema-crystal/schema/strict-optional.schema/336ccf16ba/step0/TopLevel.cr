require "json"

class TopLevel
  include JSON::Serializable

  property foo : Float64?
end
