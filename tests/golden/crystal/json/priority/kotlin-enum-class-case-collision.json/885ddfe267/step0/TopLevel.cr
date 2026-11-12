require "json"

alias TopLevel = Array(TopLevelElement)

class TopLevelElement
  include JSON::Serializable

  property category : String
end
