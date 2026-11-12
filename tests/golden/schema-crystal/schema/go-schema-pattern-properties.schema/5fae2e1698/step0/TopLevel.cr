require "json"

class TopLevel
  include JSON::Serializable

  property map : Hash(String, Int64)
end
