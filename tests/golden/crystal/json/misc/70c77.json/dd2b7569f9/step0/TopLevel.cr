require "json"

class TopLevel
  include JSON::Serializable

  property base : String

  property date : String

  property rates : Hash(String, Float64)
end
