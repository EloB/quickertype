require "json"

class TopLevel
  include JSON::Serializable

  property b : String?

  property kind : String
end
