require "json"

class TopLevel
  include JSON::Serializable

  property foo : Hash(String, Float64)
end
