require "json"

class TopLevel
  include JSON::Serializable

  property countries : Array(String)
end
