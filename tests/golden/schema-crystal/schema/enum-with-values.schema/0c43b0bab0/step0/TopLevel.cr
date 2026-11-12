require "json"

class TopLevel
  include JSON::Serializable

  property weekdays : String
end
