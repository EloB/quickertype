require "json"

alias TopLevel = Array(TopLevelElement)

class TopLevelElement
  include JSON::Serializable

  property one : Int64?

  property two : Bool

  property three : Float64?
end
