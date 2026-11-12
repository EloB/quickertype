require "json"

class TopLevel
  include JSON::Serializable

  property number : Float64
end
