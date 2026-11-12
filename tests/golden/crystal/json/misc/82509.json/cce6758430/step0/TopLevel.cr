require "json"

class TopLevel
  include JSON::Serializable

  property origin : String
end
