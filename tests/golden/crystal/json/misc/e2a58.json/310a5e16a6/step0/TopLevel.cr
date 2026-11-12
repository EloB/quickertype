require "json"

alias TopLevel = Array(TopLevelElement)

class TopLevelElement
  include JSON::Serializable

  property date : String

  @[JSON::Field(key: "stop-and-search")]
  property stop_and_search : Array(String)
end
