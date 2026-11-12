require "json"

class TopLevel
  include JSON::Serializable

  property foo : JSON::Any?

  property values : Hash(String, JSON::Any?)
end
