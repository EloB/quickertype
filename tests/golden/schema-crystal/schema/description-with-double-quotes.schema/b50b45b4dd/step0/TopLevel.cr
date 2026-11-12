require "json"

# Cool "stuff"
class TopLevel
  include JSON::Serializable

  property foo : Bool?
end
