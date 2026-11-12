require "json"

class TopLevel
  include JSON::Serializable

  property name : String

  property shortcut : String?
end
