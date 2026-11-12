require "json"

class TopLevel
  include JSON::Serializable

  property health : String
end
