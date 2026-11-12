require "json"

class TopLevel
  include JSON::Serializable

  property intersection : Intersection?
end

class Intersection
  include JSON::Serializable

  property foo : Float64

  property bar : String?
end
