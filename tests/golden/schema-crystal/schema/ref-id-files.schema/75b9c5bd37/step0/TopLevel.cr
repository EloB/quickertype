require "json"

class TopLevel
  include JSON::Serializable

  property foo : Int64
end
