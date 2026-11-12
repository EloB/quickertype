require "json"

class TopLevel
  include JSON::Serializable

  property cookies : Array(Cookie)
end

class Cookie
  include JSON::Serializable

  property name : String

  property value : String
end
