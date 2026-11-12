require "json"

alias TopLevel = Array(TopLevelElement)

class TopLevelElement
  include JSON::Serializable

  property age : Int64

  property country : String

  property females : Int64

  property males : Int64

  property total : Int64

  property year : Int64
end
