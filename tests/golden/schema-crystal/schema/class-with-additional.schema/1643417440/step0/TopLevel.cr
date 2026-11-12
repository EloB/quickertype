require "json"

class TopLevel
  include JSON::Serializable

  property map : Hash(String, Map)?
end

alias Map = Float64 | Bool
