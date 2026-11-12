require "json"

class TopLevel
  include JSON::Serializable

  property value : Float64
end
