require "json"

class TopLevel
  include JSON::Serializable

  property item : Int64
end
