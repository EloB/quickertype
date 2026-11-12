require "json"

class TopLevel
  include JSON::Serializable

  property callsign : String

  property priority : String
end
