require "json"

class TopLevel
  include JSON::Serializable

  property config : Config?
end

class Config
  include JSON::Serializable

  property closed : Closed?

  property name : String?

  property settings : Hash(String, Array(Item))?
end

class ClosedClass
  include JSON::Serializable

end

class Item
  include JSON::Serializable

  property key : String

  property value : String
end

alias Closed = Array(JSON::Any?) | ClosedClass | Float64 | Int64 | Bool | String
