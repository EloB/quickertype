require "json"

class Generated
  include JSON::Serializable

  property greeting : String

  property instructions : Array(String)
end
