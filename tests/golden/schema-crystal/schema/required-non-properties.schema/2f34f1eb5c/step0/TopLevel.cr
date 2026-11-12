require "json"

class TopLevel
  include JSON::Serializable

  property foo : Int64

  property bar : JSON::Any?
end
