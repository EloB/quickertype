require "json"

class TopLevel
  include JSON::Serializable

  property intersection : Float64?
end
