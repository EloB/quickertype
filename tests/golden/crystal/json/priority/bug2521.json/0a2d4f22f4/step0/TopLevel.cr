require "json"

class TopLevel
  include JSON::Serializable

  property options : Array(Option)
end

class Option
  include JSON::Serializable

  property foo : String?

  property name : String
end
