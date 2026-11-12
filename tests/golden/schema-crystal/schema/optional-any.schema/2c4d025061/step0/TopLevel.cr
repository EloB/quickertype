require "json"

class TopLevel
  include JSON::Serializable

  property bar : Bool

  property foo : JSON::Any?
end
