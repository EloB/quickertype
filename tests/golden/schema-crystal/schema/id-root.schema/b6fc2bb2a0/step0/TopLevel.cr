require "json"

class TopLevel
  include JSON::Serializable

  property bar : Int64
end
