require "json"

class TopLevel
  include JSON::Serializable

  property x : Array(X?)

  property y : Array(Int64?)

  property z : Array(ZElement)
end

class ZClass
  include JSON::Serializable

  property a : Bool
end

alias X = Int64 | String

alias ZElement = Int64 | Array(Int64) | ZClass
