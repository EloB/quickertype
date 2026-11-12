require "json"

class TopLevel
  include JSON::Serializable

  property greeting : String

  property instructions : Array(String)
end
