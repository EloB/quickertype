require "json"

class TopLevel
  include JSON::Serializable

  property bar : String

  property foo : String
end
