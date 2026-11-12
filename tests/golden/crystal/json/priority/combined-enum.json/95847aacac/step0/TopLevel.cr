require "json"

class TopLevel
  include JSON::Serializable

  property bar : Array(Bar)

  property foo : Array(Bar)
end

class Bar
  include JSON::Serializable

  property x : String
end
