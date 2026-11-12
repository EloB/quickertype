require "json"

class TopLevel
  include JSON::Serializable

  property exact : String

  property maximum : String

  property minimum : String
end
